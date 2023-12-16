class ChangeSchoolPointsDefault < ActiveRecord::Migration[7.0]
  def change
    change_column :schools, :points, :integer, default: 50
  end
end
