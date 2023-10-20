class CreateSurveysQuestionsAndSurveyQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys do |t|
      t.timestamps
    end

    create_table :questions do |t|
      t.string :body
      t.timestamps
    end

    create_table :survey_questions do |t|
      t.references :survey, foreign_key: true
      t.references :question, foreign_key: true
      t.timestamps
    end
  end
end
