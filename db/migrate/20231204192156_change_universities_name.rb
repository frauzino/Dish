class ChangeUniversitiesName < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :university, :school
  end
end
