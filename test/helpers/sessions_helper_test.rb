require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

	test "current member" do 
		member = members(:bibek)
		remember(member)
		assert_equal member, current_member
	end
end