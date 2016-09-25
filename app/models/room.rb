class Room < ActiveRecord::Base
  validates :building,  :presence => true
  validates :roomnumber, :presence => true, :uniqueness => {:scope => :building}
  validates :size, :presence => true
end