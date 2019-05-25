class CreateFirstRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :first_rounds do |t|
      t.string :country_name
      t.integer :position
      t.string :group

      t.timestamps
    end
  end
end
