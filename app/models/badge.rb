class Badge < ApplicationRecord
  has_many :user_badges, dependant: :destroy
  has_many :users, through: :user_badges
end
