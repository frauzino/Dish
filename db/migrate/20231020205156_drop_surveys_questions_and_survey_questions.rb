class DropSurveysQuestionsAndSurveyQuestions < ActiveRecord::Migration[7.0]
  def change
    drop_table :surveys
    drop_table :questions
    drop_table :survey_questions
  end
end
