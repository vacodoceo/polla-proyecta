class RemIdUserFromTransaction < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :id_user
  end
end
