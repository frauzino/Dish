class SurveysController < ApplicationController
  before_action :create, only: %i[show]
  skip_before_action :authenticate_user!, only: %i[show]

  def create
    @survey = Survey.new
    Question.all.each do |question|
      SurveyQuestion.create!(survey: @survey, question:)
    end
    @survey.questions = @survey.questions.sample 5
    @survey.save
  end
end


# each survey needs to have questions, not just quwestion text
