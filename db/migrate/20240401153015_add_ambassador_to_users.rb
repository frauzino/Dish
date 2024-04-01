class AddAmbassadorToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :ambassador, :boolean, null: false, default: false
  end
end
