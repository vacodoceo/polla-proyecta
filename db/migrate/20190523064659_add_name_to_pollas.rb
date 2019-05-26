class AddNameToPollas < ActiveRecord::Migration[5.2]
  def change
    add_column :pollas, :name, :string
  end
end
