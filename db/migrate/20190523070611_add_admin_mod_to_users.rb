class AddAdminModToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_admin, :bool
    add_column :users, :is_mod, :bool
  end
end
