class RemTransactionFromPollas < ActiveRecord::Migration[5.2]
  def change
    remove_column :pollas, :transaction_id
  end
end
