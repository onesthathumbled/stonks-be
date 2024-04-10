class AddColumnToTransaction < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :symbol, :string
    add_column :transactions, :company_name, :string
    rename_column :transactions, :type, :transaction_type
  end
end
