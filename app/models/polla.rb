class Polla < ApplicationRecord
  belongs_to :id_user
  has_one :id_transaction
  has_many : bets
end
