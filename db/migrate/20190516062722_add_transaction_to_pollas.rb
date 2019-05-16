class AddTransactionToPollas < ActiveRecord::Migration[5.2]
  def change
    add_reference :pollas, :transaction, foreign_key: true
  end
end
