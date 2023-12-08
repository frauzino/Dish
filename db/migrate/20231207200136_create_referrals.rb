class CreateReferrals < ActiveRecord::Migration[7.0]
  def change
    create_table :referrals do |t|
      t.string :code
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
