require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before do
    stub_request(:any, "http://accessible.url").
      to_return(status: 200, body: '')
  end

  config.before do
    stub_request(:any, "http://inaccessible.url").
      to_return(status: [500, "Internal Server Error"])
  end
end
