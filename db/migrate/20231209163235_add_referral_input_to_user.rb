class AddReferralInputToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :referral_input, :string
  end
end
