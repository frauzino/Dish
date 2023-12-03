class UserBadge < ApplicationRecord
  belongs_to :user
  belongs_to :badge

  validates :user, uniqueness: { scope: [:badge_id] }
end
