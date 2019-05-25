class AddPollaToFirstRound < ActiveRecord::Migration[5.2]
  def change
    add_reference :first_rounds, :polla, foreign_key: true
  end
end
