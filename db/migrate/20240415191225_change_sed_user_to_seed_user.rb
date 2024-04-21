class ChangeSedUserToSeedUser < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :sed_user, :seed_user
  end
end
