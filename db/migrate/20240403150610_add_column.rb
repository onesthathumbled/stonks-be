class AddColumn < ActiveRecord::Migration[7.1]
  def change
    add_column :traders, :status, :boolean, default: false, null: false
  end
end
