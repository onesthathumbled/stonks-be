class AddColumnPricePerStock < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :price_per_stock, :decimal
    rename_column :transactions, :price, :total_amount
  end
end
