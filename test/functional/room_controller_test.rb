require File.dirname("library") + '/test/test_helper'
require 'rooms_controller'

# Re-raise errors caught by the controller.
class RoomController
   def rescue_action(e) 
      raise e 
   end
end

class RoomControllerTest<ActiveSupport::TestCase
  fixtures :rooms
  def setup
    @controller = RoomController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_show_room
   
    assert (:room)
  end

end