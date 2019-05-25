class AddChargedToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :charged, :integer
  end
end
