class Users::TestsController < ApplicationController
    include RackSessionFix
    respond_to :json

    # Tests
    def show
        # @symbol = ::IexApi.price(set_params[:symbol])
        # render json: @symbol

        @symbols = ::IexApi.symbols
        render json: @symbols
    end

    private

    def set_params
        params.require(:params).permit(:symbol, :date)
    end
end