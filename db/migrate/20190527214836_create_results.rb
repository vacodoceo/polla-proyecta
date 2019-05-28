class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.string :team_1
      t.string :team_2
      t.integer :result_team_1
      t.integer :result_team_2
      t.integer :result
      t.integer :position
      t.string :group
      t.string :stage
      t.timestamps
    end
  end
end
