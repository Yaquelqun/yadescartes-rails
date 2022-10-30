class Participation < ApplicationRecord
  belongs_to :lobby
  belongs_to :user

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where.not(active: true) }
end
