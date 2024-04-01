class AddReferenceToSurveys < ActiveRecord::Migration[7.0]
  def change
    add_column :surveys, :reference, :string
  end
end
