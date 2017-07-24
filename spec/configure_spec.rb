require 'spec_helper'

describe 'Fb.configure' do
  let(:client_id) { 'ABCDEFGHIJ1234567890' }
  specify 'sets the attributes of Fb.configuration' do
    Fb.configure{|config| config.client_id = client_id}

    expect(Fb.configuration.client_id).to eq client_id
  end
end