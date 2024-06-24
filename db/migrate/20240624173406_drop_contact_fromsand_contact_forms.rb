class DropContactFromsandContactForms < ActiveRecord::Migration[7.0]
  def change
    drop_table :contact_forms
    drop_table :contact_froms
  end
end
