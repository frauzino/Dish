class SurveysController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def new
    @survey = Survey.new
    @questions = assign_questions
    @questions.each do |question|
      @survey.survey_questions << SurveyQuestion.new(survey: @survey, question:)
    end
    @survey_questions = @survey.survey_questions
  end

  def assign_questions
    questions_array = if user_signed_in?
                        [Question.second]
                      else
                        [Question.first, Question.second]
                      end
    questions_sample = Question.all[2..].sample 15
    questions_array + questions_sample
  end

  def create
    @survey = Survey.new(survey_params)
    @survey.user_id = current_user.id if user_signed_in?
    if @survey.save
      create_survey_questions(@survey)
      survey_total_value(@survey)
      create_result(@survey)
      if user_signed_in?
        add_user_points
        redirect_to survey_path(@survey)
      else
        redirect_to root_path
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @survey = current_user.surveys.last
    max_value = 0.0
    @survey.survey_questions.each do |sq|
      max_value += sq.question.options.maximum('value')
    end
    @survey_score = ((@survey.total_value / max_value) * 100).round(0)
  end

  def create_result(survey)
    results_controller = ResultsController.new
    results_controller.request = request
    results_controller.response = response
    results_controller.create(survey)
  end

  def create_survey_questions(survey)
    survey.survey_questions.each do |sq|
      opt = sq.question.options.find_by body: sq.answer
      sq.answer_value = opt.value
      sq.save
    end
  end

  def survey_total_value(survey)
    summed_value = 0
    survey.survey_questions.each do |sq|
      summed_value += sq.answer_value
    end
    survey.update(total_value: summed_value)
  end

  def add_user_points
    new_points = current_user.points += 25
    current_user.update(points: new_points)
  end

  private

  def survey_params
    params.require(:survey).permit(survey_questions_attributes: [:id, :answer, :answer_value, :photo, :question_id, { question_attributes: [:id, :body] }])
  end
end
