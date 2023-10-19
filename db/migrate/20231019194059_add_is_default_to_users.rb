class AddIsDefaultToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_default, :boolean, null: false, default: false
  end
end
