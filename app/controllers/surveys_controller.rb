class SurveysController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def new
    @survey = Survey.new
    @questions = Question.all.sample 5
    @questions.each do |question|
      @survey.survey_questions << SurveyQuestion.new(survey: @survey, question:)
    end
    @survey_questions = @survey.survey_questions
  end

  def create
    @survey = Survey.new(survey_params)
    @survey.user_id = current_user.id if user_signed_in?
    if @survey.save
      @survey.survey_questions.each(&:save)
      add_user_points if user_signed_in?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def add_user_points
    new_points = current_user.points += 10
    current_user.update(points: new_points)
  end

  private

  def survey_params
    params.require(:survey).permit(survey_questions_attributes: [:id, :answer, :question_id, { question_attributes: [:id, :body] }])
  end
end
