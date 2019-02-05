require 'test_helper'

class StallTest < ActiveSupport::TestCase
  def setup
    @user = users(:testerman)
    @stall = @user.stalls.build(description: "Lorem ipsum")
  end
  
  test "should be valid" do
    assert @stall.valid?
  end
  
  test "user id should be present" do
    @stall.user_id = nil
    assert_not @stall.valid?
  end
  
  test "description should be present" do
    @stall.description = "    "
    assert_not @stall.valid?
  end
  
  test "description should be at most 140 characters" do
    @stall.description = "a" * 141
    assert_not @stall.valid?
  end
end
