class AddUserToPollas < ActiveRecord::Migration[5.2]
  def change
    add_reference :pollas, :user, foreign_key: true
  end
end
