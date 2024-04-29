class Users::UsersController < ApplicationController
  include RackSessionFix
  before_action :authorize_trader

  before_action :set_total_cost_and_stock_price, only: [:buy, :sell]
  before_action :set_transaction_params, only: [:buy, :sell]
  respond_to :json

  def buy
    Transaction.buy(current_user, @transaction_params_with_defaults, stock_params) # Call buy method from Transaction model
    render json: { status: { code: 200, message: "Transaction Complete." } }, status: :ok
    rescue ActiveRecord::RecordInvalid
      render json: { error: "Failed to complete transaction." }, status: :unprocessable_entity
  end

  def sell
    Transaction.sell(current_user, @transaction_params_with_defaults, stock_params) # Call buy method from Transaction model
    render json: { status: { code: 200, message: "Transaction Complete." } }, status: :ok
    rescue ActiveRecord::RecordInvalid
      render json: { error: "Failed to complete transaction." }, status: :unprocessable_entity
  end


  def portfolio
    @stocks = current_user.stocks
    render json: @stocks
  end

  def transactions
    @transactions = current_user.transactions
    render json: @transactions
  end

  def wallet
    @wallet = current_user
    render json: { wallet: @wallet.wallet }
  end

  def get_stock
    symbol = params[:symbol]
    @stock = current_user.stocks.find_by(symbol: symbol)
    
    if @stock
      render json: { stock: @stock }
    else
      render json: { error: 'Stock not found' }, status: :not_found
    end
  end
  

  private

  def set_total_cost_and_stock_price
    @stock_price = ::IexApi.price(stock_params[:symbol])
    @total_cost = @stock_price * stock_params[:quantity].to_i
  end

  def set_transaction_params
    # Declaration of transaction params (Duplicating the stock_params and merging -> so stock_params will not be affected.)
    @transaction_params_with_defaults = stock_params.dup.merge(date: Date.today, total_amount: @total_cost, price_per_stock: @stock_price)
  end

  def stock_params
    params.require(:stock).permit(:symbol, :company_name, :quantity)
  end

  def authorize_trader
    unless current_user && current_user.roles === 0 && current_user.status === true
      render json: {
          status: { code: 403, message: "This feature is only available for traders." }
      }, status: :forbidden 
    end
  end
end
