class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :pollas, :valid, :valid_polla 
  end
end
