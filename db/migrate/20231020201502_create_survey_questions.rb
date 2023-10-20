class CreateSurveyQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_questions do |t|

      t.timestamps
      t.references :survey, foreign_key: true
      t.references :question, foreign_key: true
    end
  end
end
