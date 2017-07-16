require 'test_helper'

class IncomesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@income = incomes(:first)
  end

  test "should redirect create when not logged in" do 
  	assert_no_difference 'Income.count' do
  		post :create, income: { title: "First Title" }
  	end
  	assert_redirected_to login_url
  end
end
