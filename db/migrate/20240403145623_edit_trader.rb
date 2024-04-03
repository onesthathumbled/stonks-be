class EditTrader < ActiveRecord::Migration[7.1]
  def change
    add_column :traders, :status, :text, default: 'pending'
  end
end
