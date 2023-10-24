class SurveyQuestion < ApplicationRecord
  belongs_to :survey
  belongs_to :question
  accepts_nested_attributes_for :question
end
