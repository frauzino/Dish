class AddDefaultToSchoolPoints < ActiveRecord::Migration[7.0]
  def change
    change_column :schools, :points, :integer, default: 0
  end
end
