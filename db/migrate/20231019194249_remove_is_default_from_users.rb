class RemoveIsDefaultFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :is_default, :boolean
    add_column :users, :is_admin, :boolean, null: false, default: false
  end
end
