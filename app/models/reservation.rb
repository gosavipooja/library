class Reservation < ActiveRecord::Base
  validates :userid, :presence => true
  validates :time_start, :presence => true
  validates :time_end, :presence => true
  validates :userid, :presence => true
  validates :roomid, :presence => true
end