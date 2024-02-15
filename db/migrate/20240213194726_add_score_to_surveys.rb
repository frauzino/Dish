class AddScoreToSurveys < ActiveRecord::Migration[7.0]
  def change
    add_column :surveys, :score, :integer
  end
end
