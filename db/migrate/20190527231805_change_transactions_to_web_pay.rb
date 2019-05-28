class ChangeTransactionsToWebPay < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :bank
    remove_column :transactions, :bank_account_number
    add_column :transactions, :description, :string
    add_column :transactions, :pay_date, :date
    add_column :transactions, :payment_method_id, :integer
    add_column :transactions, :tbk_transaction_id, :string
    add_column :transactions, :tbk_token, :string
    add_column :transactions, :state, :string
    add_column :transactions, :webpay_data, :string

  end
end
