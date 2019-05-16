class AddMatchToBets < ActiveRecord::Migration[5.2]
  def change
    add_reference :bets, :match, foreign_key: true
  end
end
