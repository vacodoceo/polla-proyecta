class Transaction < ApplicationRecord
  belongs_to :id_user
  has_many :pollas
end
