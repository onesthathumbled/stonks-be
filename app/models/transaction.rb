class Transaction < ApplicationRecord
  belongs_to :user

  def self.buy(user, transaction_attributes, stock_attributes)
    ActiveRecord::Base.transaction do
      transaction = user.transactions.build(transaction_attributes)
      transaction.transaction_type = 'Buy'
      transaction.save!

      stock = user.stocks.find_by(symbol: stock_attributes[:symbol])
      if stock.present?
        # Update existing stock
        total_quantity = stock.quantity + stock_attributes[:quantity].to_i
        stock.update(quantity: total_quantity)
      else
        # Create new stock
        stock = user.stocks.build(stock_attributes)
      end
      stock.save!

      user.wallet -= transaction.total_amount
      user.save!
    end
  end

  def self.sell(user, transaction_attributes, stock_attributes)
    ActiveRecord::Base.transaction do
      transaction = user.transactions.build(transaction_attributes)
      transaction.transaction_type = 'Sell'
      transaction.save!

      stock = user.stocks.find_by(symbol: stock_attributes[:symbol])

      total_quantity = stock.quantity.to_i - stock_attributes[:quantity].to_i
      stock.update(quantity: total_quantity)
      stock.save!

      user.wallet += transaction.total_amount
      user.save!
    end
  end

end


