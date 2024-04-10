class DropTradersTable < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :transactions, column: :user_id
    drop_table :traders
  end
end
