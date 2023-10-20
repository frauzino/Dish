class SurveysController < ApplicationController
  before_action :create, only: %i[show]

  def create
    @survey = Survey.new
    5.times do
      SurveyQuestion.create!(survey: @survey, question: Question.all.sample)
    end
    @survey.save
  end
end


# each survey needs to have questions, not just quwestion text
