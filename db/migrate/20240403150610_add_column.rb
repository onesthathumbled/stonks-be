class AddColumn < ActiveRecord::Migration[7.1]
  def change
    remove_column :traders, :status
    add_column :traders, :status, :boolean, default: false, null: false
  end
end
