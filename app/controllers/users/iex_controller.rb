class Users::IexController < ApplicationController
    include RackSessionFix
    respond_to :json

    def index
        @symbols = ::IexApi.market
        render json: @symbols
    end

    def show
        @symbol = ::IexApi.ohlc(set_params[:symbol])
        render json: @symbol
    end
    
    def market
        @symbols = ::IexApi.symbols
        render json: @symbols
    end

    def quote
        @symbol = ::IexApi.quote(quote_params[:symbol])
        render json: @symbol
    end

    def top10
        @list = ['AAPL', 'AMZN', 'GOOGL', 'MSFT', 'TSLA', 'FB', 'JNJ', 'KO', 'WMT', 'JPM']
        @stocks = []
        @list.each do | stock |
            quote = ::IexApi.quote(stock)
            @stocks.push(quote)
        end
        render json: @stocks
    end

    private

    def quote_params
        params.require(:params).permit(:symbol)
    end

    def set_params
        params.require(:params).permit(:symbol)
    end

end
