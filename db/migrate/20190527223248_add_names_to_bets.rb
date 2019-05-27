class AddNamesToBets < ActiveRecord::Migration[5.2]
  def change
    add_column :bets, :country_1_name, :string
    add_column :bets, :country_2_name, :string
    add_column :bets, :stage, :string
  end
end
