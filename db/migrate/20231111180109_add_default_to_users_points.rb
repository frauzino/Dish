class AddDefaultToUsersPoints < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :points, :integer, default: 0
  end
end
