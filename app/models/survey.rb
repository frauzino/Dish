class Survey < ApplicationRecord
  has_many :survey_questions
  has_many :questions, through: :survey_questions
end
