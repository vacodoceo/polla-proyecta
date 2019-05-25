class AddPayingToPollas < ActiveRecord::Migration[5.2]
  def change
    add_column :pollas, :paying, :integer
  end
end
