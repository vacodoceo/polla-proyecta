class RemIdUserFromPolla < ActiveRecord::Migration[5.2]
  def change
    remove_column :pollas, :id_user
  end
end
