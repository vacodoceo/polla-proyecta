class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.string :team_1_name
      t.string :team_2_name
      t.integer :team_1_result
      t.integer :team_2_result
      t.integer :edited

      t.timestamps
    end
  end
end
