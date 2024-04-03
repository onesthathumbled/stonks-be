class AddOtherTables < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.string :name
      t.integer :quantity
      t.decimal :price
      t.references :trader, foreign_key: true

      t.timestamps
    end

    create_table :transactions do |t|
      t.string :type
      t.date :date
      t.integer :quantity
      t.decimal :price
      t.references :trader, foreign_key: true
      t.references :stock, foreign_key: true
    end
  end
end
