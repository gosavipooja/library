require File.dirname("library") + '/test/test_helper'

class RoomTest < ActiveSupport::TestCase
  fixtures :rooms

  def test_room
    
    one_member = Room.new     :roomnumber => rooms(:one).roomnumber, 
                         :building => rooms(:one).building,
                         :size => rooms(:one).size,
                         :created_at => rooms(:one).created_at,
						 :id => rooms(:one).id
                         
    assert_not one_member.save

    one_member_copy = Room.find(one_member.id)

    assert_equal one_member.roomnumber, one_member_copy.roomnumber

    one_member.roomnumber = "49"
    one_member.id= 34
    assert one_member.save
    assert one_member.destroy
  end

end