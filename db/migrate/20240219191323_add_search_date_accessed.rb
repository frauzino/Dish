class AddSearchDateAccessed < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :search_date_accessed, :time, array: true, default: []
  end
end
