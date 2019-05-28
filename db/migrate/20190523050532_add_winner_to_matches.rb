class AddWinnerToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :winner, :string
  end
end
