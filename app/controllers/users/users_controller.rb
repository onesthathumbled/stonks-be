class Users::UsersController < ApplicationController
    include RackSessionFix
    respond_to :json

    def buy
      stock_price = ::IexApi.ohlc(stock_params[:symbol]) # Fetching Price from IEX
      stock_cost = stock_price.open.price * stock_params[:quantity].to_i
      transaction_params_with_defaults = transaction_params.merge(transaction_type: 'Buy', date: Date.today, total_amount: stock_cost, price_per_stock: stock_price.open.price) # Merging the defaults and other params
    
      @transaction = current_user.transactions.build(transaction_params_with_defaults)
      @stock = current_user.stocks.find_by(symbol: stock_params[:symbol])
      @wallet = current_user.wallet - stock_cost
    
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

    def stock_params
    params.require(:stock).permit(:symbol, :company_name, :quantity)
    end

    def transaction_params
    params.require(:transaction).permit(:symbol, :company_name, :quantity)
    end
end
