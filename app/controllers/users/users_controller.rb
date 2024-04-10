class Users::UsersController < ApplicationController
    include RackSessionFix
    respond_to :json

    def portfolio
        @stocks = current_user.stocks
        render json: @stocks
    end

    def transactions
        @transactions = current_user.transactions
        render json: @transactions
    end

    private

    # def stock_params
    #     params.require(:stocks).permit(:symbol, :company_name, :quantity)
    # end
end
