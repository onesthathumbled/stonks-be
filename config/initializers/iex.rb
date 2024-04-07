require 'iex-ruby-client'

IEX::Api.configure do |config|
    config.publishable_token = ENV['IEX_API_TOKEN']
    config.endpoint = 'https://cloud.iexapis.com/v1'
end