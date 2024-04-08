module IexApi
  @client = IEX::Api::Client.new(
  publishable_token: ENV['IEX_API_TOKEN'],
  secret_token: ENV['IEX_API_SECRET_TOKEN'],
  endpoint: 'https://cloud.iexapis.com/v1'
)

  def self.price(symbol)
    @client.price(symbol)
  end
end
