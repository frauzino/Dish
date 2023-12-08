class Referral < ApplicationRecord
  belongs_to :user
  validates :code, presence: true, uniqueness: true
  validates :user, uniqueness: true
end
