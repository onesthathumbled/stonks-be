class ChangeStocks < ActiveRecord::Migration[7.1]
  def change
    change_column :stocks, :quantity, :integer
  end
end
