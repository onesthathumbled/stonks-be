class EditagainTrader < ActiveRecord::Migration[7.1]
  def change
    change_column :traders, :status, :text
  end
end
