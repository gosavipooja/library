class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :roomnumber
      t.string :building
      t.integer :size

      t.timestamps null: false
    end
  end
end
