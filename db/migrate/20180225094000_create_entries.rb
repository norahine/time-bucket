class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.integer :activity_id, null: false
      t.integer :duration, null: false
      t.date :date, null: false
      t.text :note

      t.timestamps
    end
    add_foreign_key :entries, :activities
  end
end
