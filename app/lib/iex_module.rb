module IEXtension
    extend self

    def get_stock_price(symbol)
        client = IEX::Api::Client.new
        client.price(symbol)
    end
end