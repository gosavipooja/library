class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :userid
      t.string :text
      t.timestamp :time_start

      t.timestamps null: false
    end
  end
end
