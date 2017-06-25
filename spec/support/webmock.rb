require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before do
    stub_request(:any, "http://accessible.url").
      to_return(status: 200, body: '')
  end
end
