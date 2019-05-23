class AddPollaToBets < ActiveRecord::Migration[5.2]
  def change
    add_reference :bets, :polla, foreign_key: true
  end
end
