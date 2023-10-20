class AddQuestionsAndNameToSurveys < ActiveRecord::Migration[7.0]
  def change
    add_column :surveys, :name, :string
  end
end
