class Pile < ApplicationRecord
  belongs_to :lobby
  has_many :cards, as: :owner
end
