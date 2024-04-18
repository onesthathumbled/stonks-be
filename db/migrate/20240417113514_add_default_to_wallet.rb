class AddDefaultToWallet < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :wallet, 0
  end
end
