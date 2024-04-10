class CreateStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :company_name
      t.decimal :quantity
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
