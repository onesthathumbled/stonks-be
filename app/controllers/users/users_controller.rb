class Users::UsersController < ApplicationController
    include RackSessionFix
    before_action :set_total_cost_and_stock_price, only: :buy
    before_action :set_transaction_params, only: :buy
    respond_to :json

    def buy
      @transaction = current_user.transactions.build(@transaction_params_with_defaults)
      @stock = current_user.stocks.find_by(symbol: stock_params[:symbol])
      @wallet = current_user.wallet - @total_cost
    
      if @stock.present?
        # Update existing stock
        total_quantity = @stock.quantity + stock_params[:quantity].to_i
        @stock.update(quantity: total_quantity)
      else
        # Create new stock
        @stock = current_user.stocks.build(stock_params)
      end
    
      if @transaction.save && @stock.save 
        current_user.update(wallet: @wallet) # Update user's wallet balance
        render json: { status: { code: 200, message: "Transaction Complete." } }, status: :ok
      else
        render json: { error: "Failed to complete transaction." }, status: :unprocessable_entity
      end
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

    def set_total_cost_and_stock_price
      @stock_price = ::IexApi.price(stock_params[:symbol]) 
      @total_cost = @stock_price * stock_params[:quantity].to_i 
    end

    def set_transaction_params
      # Declaration of transaction params (Duplicating the stock_params and mergin -> so stock_params will not be affected.)
      @transaction_params_with_defaults = stock_params.dup.merge(transaction_type: 'Buy', date: Date.today, total_amount: @total_cost, price_per_stock: @stock_price)
    end

    def stock_params
    params.require(:stock).permit(:symbol, :company_name, :quantity)
    end

    def transaction_params
    params.require(:transaction).permit(:symbol, :company_name, :quantity)
    end
end
