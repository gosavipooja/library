class Room < ActiveRecord::Base
  validates :roomnumber, :presence => true, :uniqueness => true
  validates :size, :presence => true
  validates :building,  :presence => true
end