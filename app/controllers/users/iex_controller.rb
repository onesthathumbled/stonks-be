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

    private

    def set_params
        params.require(:params).permit(:symbol)
    end

end
