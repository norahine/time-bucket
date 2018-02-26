class AddIsDeletedToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :is_deleted, :boolean, null: false, default: false
  end
end
