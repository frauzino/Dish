class AddPointsToOptionsAndSurveyAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :options, :value, :integer
    add_column :survey_questions, :answer_value, :integer
    add_column :surveys, :total_value, :integer
  end
end
