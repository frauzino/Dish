class CreateNewsletterTargets < ActiveRecord::Migration[7.0]
  def change
    create_table :newsletter_targets do |t|
      t.string :email

      t.timestamps
    end
  end
end
