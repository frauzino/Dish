class AddDefaultToReferralInput < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :referral_input, :string, default: nil
  end
end
