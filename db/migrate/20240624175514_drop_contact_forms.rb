class DropContactForms < ActiveRecord::Migration[7.0]
  def change
    drop_table :contact_forms
  end
end
