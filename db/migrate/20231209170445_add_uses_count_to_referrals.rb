class AddUsesCountToReferrals < ActiveRecord::Migration[7.0]
  def change
    add_column :referrals, :uses_count, :integer
  end
end
