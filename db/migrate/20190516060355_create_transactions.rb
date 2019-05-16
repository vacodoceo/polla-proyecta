class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :id_user
      t.integer :amount
      t.string :bank
      t.integer :bank_account_number
      t.integer :payment_id
      t.string :payment_url

      t.timestamps
    end
  end
end
