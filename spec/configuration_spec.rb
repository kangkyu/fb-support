require 'spec_helper'

describe Fb::Configuration do
  subject(:config) { Fb::Configuration.new }

  describe '#client_id' do
    context 'without an environment variable FB_CLIENT_ID' do
      before { ENV['FB_CLIENT_ID'] = nil }
      it {expect(config.client_id).to be_nil }
    end

    context 'given an environment variable FB_CLIENT_ID' do
      let(:client_id) { '1234567890' }
      before { ENV['FB_CLIENT_ID'] = client_id}
      it {expect(config.client_id).to eq client_id }
    end
  end

  describe '#client_secret' do
    context 'without an environment variable FB_CLIENT_SECRET' do
      before { ENV['FB_CLIENT_SECRET'] = nil }
      it {expect(config.client_secret).to be_nil }
    end

    context 'given an environment variable FB_CLIENT_SECRET' do
      let(:client_secret) { '1234567890' }
      before { ENV['FB_CLIENT_SECRET'] = client_secret}
      it {expect(config.client_secret).to eq client_secret }
    end
  end

  describe 'developing?' do
    context 'with FB_LOG_LEVEL not set to devel' do
      before { ENV['FB_LOG_LEVEL'] = nil }
      it {expect(config).not_to be_developing }
    end

    context 'with FB_LOG_LEVEL set to devel' do
      before { ENV['FB_LOG_LEVEL'] = 'devel' }
      after { ENV['FB_LOG_LEVEL'] = nil }
      it {expect(config).to be_developing }
    end
  end
end
