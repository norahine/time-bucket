class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.integer :user_id, null: false
      t.string :name, null: false

      t.timestamps
    end
    add_foreign_key :activities, :users
  end
end
