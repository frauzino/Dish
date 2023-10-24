class RemoveAnswersFromQuestionsAddToSurveyQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :answer, :string
    add_column :survey_questions, :answer, :string
  end
end
