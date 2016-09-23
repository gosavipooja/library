class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :room_no
      t.string :size
      t.string :building

      t.timestamps null: false
    end
  end
end
