class Question < ApplicationRecord
  has_many :survey_questions
  has_many :options
end
