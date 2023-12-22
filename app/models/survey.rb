class Survey < ApplicationRecord
  has_many :survey_questions, dependant: :destroy
  has_many :questions, through: :survey_questions, dependant: :destroy
  accepts_nested_attributes_for :survey_questions
  accepts_nested_attributes_for :questions
  belongs_to :user
  has_one :result, dependant: :destroy
  has_one_attached :photo
end
