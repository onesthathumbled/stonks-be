require 'iex-ruby-client'

IEX::Api.configure do |config|
    config.publishable_token = 'PUBLISHABLE TOKEN'
    config.endpoint = 'IEX ENDPOINT'
end