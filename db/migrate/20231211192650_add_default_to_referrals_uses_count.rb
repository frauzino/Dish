class AddDefaultToReferralsUsesCount < ActiveRecord::Migration[7.0]
  def change
    change_column :referrals, :uses_count, :integer, default: 0
  end
end
