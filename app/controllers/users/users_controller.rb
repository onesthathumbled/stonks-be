class Users::UsersController < ApplicationController
    include RackSessionFix
    respond_to :json

    def buy
        stock_price = ::IexApi.ohlc(stock_params[:symbol])
        transaction_params_with_defaults = transaction_params.merge(transaction_type: 'Buy', date: Date.today, price: stock_price.open.price)
        @transaction = current_user.transactions.build(transaction_params_with_defaults)
        @stock = current_user.stocks.find_by(symbol: stock_params[:symbol])
      
        if @stock.present?
          # Update existing stock
          total_quantity = @stock.quantity + stock_params[:quantity].to_i
          @stock.update(quantity: total_quantity)
        else
          # Create new stock
          @stock = current_user.stocks.build(stock_params)
        end
      
        if @transaction.save && @stock.save
          render json: { status: { code: 200, message: "Transaction Complete." } }, status: :ok
        else
          render json: { error: "Failed to complete transaction." }, status: :unprocessable_entity
        end
    end

    def sell
        
    end


    def portfolio
        @stocks = current_user.stocks
        render json: @stocks
    end

    def transactions
        @transactions = current_user.transactions
        render json: @transactions
    end

    private

    def stock_params
    params.require(:stock).permit(:symbol, :company_name, :quantity)
    end

    def transaction_params
    params.require(:transaction).permit(:symbol, :company_name, :quantity)
    end
end
