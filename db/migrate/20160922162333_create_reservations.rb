class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :userid
      t.integer :roomid
      t.timestamp :time_start
      t.timestamp :time_end

      t.timestamps null: false
    end
  end
end
