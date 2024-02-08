class Survey < ApplicationRecord
  has_many :survey_questions, dependent: :destroy
  has_many :questions, through: :survey_questions, dependent: :destroy
  accepts_nested_attributes_for :survey_questions
  accepts_nested_attributes_for :questions
  belongs_to :user, optional: true
  has_one :result, dependent: :destroy
  has_one_attached :photo
end
