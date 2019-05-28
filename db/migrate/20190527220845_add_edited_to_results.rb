class AddEditedToResults < ActiveRecord::Migration[5.2]
  def change
    add_column :results, :edited, :integer
  end
end
