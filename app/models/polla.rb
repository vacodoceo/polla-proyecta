class Polla < ApplicationRecord
  belongs_to :user
  #has_one :transaction
  has_one :owner, foreign_key: "transaction_id", class_name: "Transaction"
  has_many :bets, dependent: :delete_all
  has_many :first_rounds, dependent: :delete_all
end
