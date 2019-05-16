class CreatePollas < ActiveRecord::Migration[5.2]
  def change
    create_table :pollas do |t|
      t.integer :id_user
      t.integer :valid
      t.integer :score

      t.timestamps
    end
  end
end
