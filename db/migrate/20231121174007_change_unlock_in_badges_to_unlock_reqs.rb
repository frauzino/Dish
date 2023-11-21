class ChangeUnlockInBadgesToUnlockReqs < ActiveRecord::Migration[7.0]
  def change
    rename_column :badges, :unlock, :unlock_reqs
    add_column :badges, :unlocked, :boolean, default: false
  end
end
