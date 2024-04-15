class Transaction < ApplicationRecord
  belongs_to :user

  def self.buy(user, transaction_attributes, stock_attributes)
    ActiveRecord::Base.transaction do
      transaction = user.transactions.build(transaction_attributes)
      transaction.save!

      stock = user.stocks.find_by(symbol: stock_attributes[:symbol])
      if stock.present?
        # Update existing stock
        total_quantity = stock.quantity + stock_attributes[:quantity].to_i
        stock.update(quantity: total_quantity)
      else
        # Create new stock
        stock = user.stocks.build(stock_attributes)
        stock.save!
      end

      user.wallet -= transaction.total_amount
      user.save!
    end
  end
end


