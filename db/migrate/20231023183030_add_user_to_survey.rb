class AddUserToSurvey < ActiveRecord::Migration[7.0]
  def change
    add_reference :surveys, :user, index: true, foreign_key: true
  end
end
