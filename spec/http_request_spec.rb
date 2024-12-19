require 'spec_helper'

describe 'Fb::HTTPRequest#run' do
  let(:params) { {fields: 'id,name', access_token: access_token} }
  let(:request) { Fb::HTTPRequest.new path: path, params: params }
  let(:access_token) { ENV['FB_TEST_ACCESS_TOKEN'] }

  context 'given a valid GET request to a Facebook Graph API endpoint' do
    let(:path) { '/v21.0/1358426871806328' }

    it 'returns the HTTP response with the JSON-parsed body' do
      response = request.run
      expect(response).to be_a Net::HTTPOK
      expect(response.body).to be_a Hash
    end
  end

  context 'given a invalid GET request to a Facebook JSON API' do
    let(:path) { '/v2.10/1' }
    let(:message) { "Unsupported get request. Object with ID '1' does not exist, cannot be loaded due to missing permissions, or does not support this operation. Please read the Graph API documentation at https://developers.facebook.com/docs/graph-api" }

    it 'raises an HTTPError' do
      expect{request.run}.to raise_error Fb::HTTPError, message
    end
  end

  context 'given a valid request with a callback set' do
    let(:path) { '/v21.0/1358426871806328' }
    let(:request) { Fb::HTTPRequest.new path: path, params: params }

    before do
      @request = nil
      @response = nil
      Fb::HTTPRequest.on_response = lambda { |req, res|
        @request = req
        @response = res
      }
    end

    after do
      Fb::HTTPRequest.on_response = lambda {|_,_|}
    end

    it 'calls the callback with the response object' do
      request.run
      expect(@request).to be_a(Fb::HTTPRequest)
      expect(@response).to be_a(Net::HTTPOK)
    end
  end
end

describe 'Fb::HTTPRequest#url' do
  let(:options) { {host: 'www.facebook.com', path: '/test', params: {id: 1}} }
  let(:request) { Fb::HTTPRequest.new options }

  context 'given a valid GET request to a Facebook Graph API endpoint' do
    it 'returns the request URL' do
      expect(request.url).to eq 'https://www.facebook.com/test?id=1'
    end
  end
end

describe 'Fb::HTTPRequest#rate_limiting_header' do
  let(:params) { {fields: 'id', access_token: access_token} }
  let(:request) { Fb::HTTPRequest.new path: path, params: params }
  let(:access_token) { ENV['FB_TEST_ACCESS_TOKEN'] }
  let(:path) { '/v21.0/1358426871806328' }

  context 'given a valid GET request to a Facebook Graph API endpoint' do
    it 'returns the request rate limiting header' do
      expect(request.rate_limiting_header).to be_a(Hash)
    end
  end
end
