class Card < ApplicationRecord
  belongs_to :owner, polymorphic: true
  belongs_to :player, class_name: 'User', optional: true

  validates :owner_type, inclusion: { in: ['User', 'Pile', 'Trick'] }
end
