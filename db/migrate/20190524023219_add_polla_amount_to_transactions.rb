class AddPollaAmountToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :polla, foreign_key: true
  end
end
