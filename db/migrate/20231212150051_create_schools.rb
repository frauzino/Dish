class CreateSchools < ActiveRecord::Migration[7.0]
  def change
    create_table :schools do |t|
      t.string :name
      t.integer :points

      t.timestamps
    end
    remove_column :users, :school, :string
    add_reference :users, :school, foreign_key: true
  end
end
