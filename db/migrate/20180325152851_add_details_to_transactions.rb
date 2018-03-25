class AddDetailsToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :amount, :float, scale: 2
    add_column :transactions, :currency, :string
    add_column :transactions, :beneficiary_name, :string
    add_column :transactions, :beneficiary_account_number, :string
    add_column :transactions, :beneficiary_account_number_code, :string
    add_column :transactions, :beneficiary_bank_id, :string
    add_column :transactions, :beneficiary_bank_id_code, :string
    add_column :transactions, :debtor_name, :string
    add_column :transactions, :debtor_account_number, :string
    add_column :transactions, :debtor_account_number_code, :string
    add_column :transactions, :debtor_bank_id, :string
    add_column :transactions, :debtor_bank_id_code, :string
  end
end
