class AddSeedUserToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :sed_user, :boolean, null: false, default: false
  end
end
