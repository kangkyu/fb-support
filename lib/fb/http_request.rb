require 'net/http'
require 'json'
require 'fb/http_error'

module Fb
  # A wrapper around +Net::HTTP+ to send HTTP requests to any web API and
  # return their result or raise an error if the result is unexpected.
  # The basic way to use Request is by calling +run+ on an instance.
  # @example Get information about Fullscreen’s Facebook page
  #   path = '/v2.10/221406534569729'
  #   params = {fields: 'id,link,about', access_token: access_token}
  #   response = Fb::HTTPRequest.new(path: path, params: params).run
  #   response.body
  # @api private
  class HTTPRequest
    # Initializes a Request object.
    # @param [Hash] options the options for the request.
    # @option options [Symbol] :method (:get) The HTTP method to use.
    # @option options [Class] :expected_response (Net::HTTPSuccess) The class
    #   of response that the request should obtain when run.
    # @option options [String] :host The host of the request URI.
    # @option options [String] :path The path of the request URI.
    # @option options [Hash] :params ({}) The params to use as the query
    #   component of the request URI, for instance the Hash +{a: 1, b: 2}+
    #   corresponds to the query parameters +"a=1&b=2"+.
    # @option options [#size] :body The body of the request.
    # @option options [Proc] :error_message The block that will be invoked
    #   when a request fails.
    def initialize(options = {})
      @method = options.fetch :method, :get
      @expected_response = options.fetch :expected_response, Net::HTTPSuccess
      @host = options.fetch :host, 'graph.facebook.com'
      @path = options[:path]
      @params = options.fetch :params, {}
    end

    class << self
      @@on_response = lambda {|_|}

      # Callback invoked with the response object on a successful response. Defaults to a noop.
      def on_response
        @@on_response
      end

      def on_response=(callback)
        @@on_response = callback
      end
    end

    # Sends the request and returns the response with the body parsed from JSON.
    # @return [Net::HTTPResponse] if the request succeeds.
    # @raise [Fb::HTTPError] if the request fails.
    def run
      if response.is_a? @expected_response
        self.class.on_response.call(response)
        response.tap do
          parse_response!
        end
      else
        raise HTTPError.new(error_message, response: response)
      end
    end

    # @return [String] the request URL.
    def url
      uri.to_s
    end

    # @return [Hash] rate limit status in the response header.
    def rate_limiting_header
      usage = response.to_hash['x-app-usage']
      JSON usage[0] if usage
    end

  private

    # @return [URI::HTTPS] the (memoized) URI of the request.
    def uri
      @uri ||= URI::HTTPS.build host: @host, path: @path, query: query
    end

    def query
      URI.encode_www_form @params
    end

    # @return [Net::HTTPRequest] the full HTTP request object.
    def http_request
      net_http_class = Object.const_get "Net::HTTP::#{@method.capitalize}"
      @http_request ||= net_http_class.new uri.request_uri
    end

    def as_curl
      'curl'.tap do |curl|
        curl <<  " -X #{http_request.method}"
        http_request.each_header{|k, v| curl << %Q{ -H "#{k}: #{v}"}}
        curl << %Q{ "#{url}"}
      end
    end

    # Run the request and memoize the response or the server error received.
    def response
      @response ||= Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        curl_request = as_curl
        print "#{curl_request}\n" if Fb.configuration.developing?
        http.request http_request
      end
    end

    # Replaces the body of the response with the parsed version of the body,
    # according to the format specified in the HTTPRequest.
    def parse_response!
      if response.body
        response.body = JSON response.body
      end
    end

    def error_message
      JSON(response.body)['error']['message']
    end
  end
end
