class Bet < ApplicationRecord
  has_many :matches
  belongs_to :polla
end
