class AddBodyToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :body, :string
  end
end
