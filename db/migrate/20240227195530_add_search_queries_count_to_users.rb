class AddSearchQueriesCountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :search_date_queries_count, :integer, default: 0
  end
end
