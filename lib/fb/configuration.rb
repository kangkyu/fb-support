module Fb
  # Provides an object to store global configuration settings.
  #
  # This class is typically not used directly, but by calling
  # {Fb::Config#configure Fb.configure}, which creates and updates a single
  # instance of {Fb::Models::Configuration}.
  #
  # @example Set the API client id/secret for a web-client Facebook app:
  #   Fb.configure do |config|
  #     config.client_id = 'ABCDEFGHIJ1234567890'
  #     config.client_secret = 'ABCDEFGHIJ1234567890'
  #   end
  #
  # @see Fb::Config for more examples.
  #
  # An alternative way to set global configuration settings is by storing
  # them in the following environment variables:
  #
  # * +FB_CLIENT_ID+ to store the Client ID for a Facebook app
  # * +FB_CLIENT_SECRET+ to store the Client Secret for a Facebook app
  #
  # In case both methods are used together,
  # {Fb::Config#configure Fb.configure} takes precedence.
  #
  # @example Set the API client id/secret for a Facebook app:
  #   ENV['FB_CLIENT_ID'] = 'ABCDEFGHIJ1234567890'
  #   ENV['FB_CLIENT_SECRET'] = 'ABCDEFGHIJ1234567890'
  #
  class Configuration
    # @return [String] the Client ID for Facebook applications.
    attr_accessor :client_id

    # @return [String] the Client Secret for web/device Facebook applications.
    attr_accessor :client_secret

    # @return [String] the level of output to print for debugging purposes.
    attr_accessor :log_level

    # Initialize the global configuration settings, using the values of
    # the specified following environment variables by default.
    def initialize
      @client_id = ENV['FB_CLIENT_ID']
      @client_secret = ENV['FB_CLIENT_SECRET']
      @log_level = ENV['FB_LOG_LEVEL']
    end

    # @return [Boolean] whether the logging output is extra-verbose.
    #   Useful when developing (e.g., to print the curl of every request).
    def developing?
      %w(devel).include? log_level.to_s
    end
  end
end