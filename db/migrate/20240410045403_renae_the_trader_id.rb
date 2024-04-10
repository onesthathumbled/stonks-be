class RenaeTheTraderId < ActiveRecord::Migration[7.1]
  def change
    rename_column :transactions, :trader_id, :user_id
  end
end
