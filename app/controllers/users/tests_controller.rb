class Users::TestsController < ApplicationController
    include RackSessionFix
    respond_to :json

    # Tests
    def show
        @symbol = ::IexApi.ohlc(set_params[:symbol])
        render json: @symbol
    end

    private

    def set_params
        params.require(:params).permit(:symbol, :date)
    end
end