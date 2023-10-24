class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|

      t.timestamps
      t.string :body
      t.references :question, foreign_key: true
    end
  end
end
