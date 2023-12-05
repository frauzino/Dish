class AddUniversityToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :university, :string
  end
end
