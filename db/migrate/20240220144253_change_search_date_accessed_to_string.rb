class ChangeSearchDateAccessedToString < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :search_date_accessed, :string, array: true, default: []
  end
end
