class Bet < ApplicationRecord
  has_many :matches
  belongs_to :id_polla
end
