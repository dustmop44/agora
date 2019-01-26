require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
    test "full title helper" do
        assert_equal full_title, "Your Local Market"
        assert_equal full_title("help"), "Help | Your Local Market"
    end
end