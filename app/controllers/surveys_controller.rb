class SurveysController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create show]

  def index
    @survey = Survey.find_by(uuid: params[:uuid])
    if @survey
      @photo_url = Cloudinary::Utils.cloudinary_url('development/' + @survey.photo.key)
      @result = { survey: @survey, photo_url: @photo_url }
      respond_to do |format|
        format.json { render json: @result }
      end
    else
      respond_to do |format|
        format.json { head :no_content }
      end
    end
  end

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
    questions_sample = user_signed_in? && current_user.is_admin ? (Question.all[2..].sample 5) : (Question.all[2..].sample 15)
    questions_array + questions_sample
  end

  def create
    @survey = Survey.new(survey_params)
    @survey.user_id = current_user.id if user_signed_in?
    if @survey.save
      create_survey_questions(@survey)
      survey_total_value(@survey)
      create_result(@survey)
      add_user_points if user_signed_in?
      redirect_to survey_path(@survey)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    if user_signed_in?
      @survey = current_user.surveys.last
      max_value = 0.0
      @survey.survey_questions.each do |sq|
        max_value += sq.question.options.maximum('value')
      end
      @survey_score = ((@survey.total_value / max_value) * 100).round(0)
    else
      @survey = nil
    end
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
    max_value = 0.0
    survey.survey_questions.each do |sq|
      summed_value += sq.answer_value
      max_value += sq.question.options.maximum('value')
    end
    survey.update(total_value: summed_value, score: ((summed_value / max_value) * 100).round(0))
  end

  def add_user_points
    new_points = current_user.points += 25
    current_user.update(points: new_points)
  end

  private

  def survey_params
    params.require(:survey).permit(:uuid, :reference, :score, :photo, survey_questions_attributes: [:id, :answer, :answer_value, :photo, :question_id, { question_attributes: [:id, :body] }])
  end
end
