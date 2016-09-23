class Room < ActiveRecord::Base
validates :room_no, :presence => true, :uniqueness => true
validates :size, :presence => true
validates :building,  :presence => true

end
