class CreateBets < ActiveRecord::Migration[5.2]
  def change
    create_table :bets do |t|
      t.integer :result_team_1
      t.integer :result_team_2
      t.string :result
      t.string :integer

      t.timestamps
    end
  end
end
