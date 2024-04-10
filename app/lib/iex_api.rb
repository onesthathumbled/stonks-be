module IexApi
  @client = IEX::Api::Client.new(
  publishable_token: ENV['IEX_API_TOKEN'],
  secret_token: ENV['IEX_API_SECRET_TOKEN'],
  endpoint: 'https://cloud.iexapis.com/v1'
)

  # Get a Single Price
  def self.price(symbol)
    @client.price(symbol)
  end

  # Get a Quote
  def self.quote(symbol)
    @client.quote(symbol)
  end

  # Get a OHLC (Open, High, Low, Close) price
  def self.ohlc(symbol)
    @client.ohlc(symbol)
  end

  # Get a Market OHLC (Open, High, Low, Close) prices
  def self.market
    @client.market
  end

  # < ---------- HISTORICAL DATA ----------- >

  # One day of data
  # Date format eg. "2020-90-30"
  def day_of_historical_data(symbol, date)
    @client.historical_prices(symbol, {range: 'date', date: Date.parse(date), chartByDay: 'true'})
  end

  # 5 days of data
  def days5_of_historical_data(symbol)
    @client.historical_prices(symbol, {range: '5d'})
  end

  # One month of data
  def month1_of_historical_data(symbol)
    @client.historical_prices(symbol)
  end

  # 6 months of data
  def month6_of_historical_data(symbol)
    @client.historical_prices(symbol, {range: '6m'})
  end

  # Year to date data
  def year_of_historical_data(symbol)
    @client.historical_prices(symbol, {range: 'ytd'})
  end

end
