class ChangeToDecimal < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :wallet, :decimal, precision: 10, scale: 2, default: 0.0, null: false
  end
end
