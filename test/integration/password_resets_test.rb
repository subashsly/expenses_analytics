require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
  	ActionMailer::Base.deliveries.clear
  	@member = members(:bibek)
  end

  test "password reset" do 
  	get new_password_reset_path
  	# Invalid submission
  	post password_resets_path, password_reset: { member_email: "" }
  	assert_template 'password_resets/new'
  	# Valid submission
  	post password_resets_path, password_reset: { member_email: @member.member_email }
  	assert_redirected_to root_url
  	# Get the member from the create action.
  	member = assigns(:member)
  	follow_redirect!
  	assert_select 'div.alert'
  	assert_equal 1, ActionMailer::Base.deliveries.size
  	# Wrong email
  	get edit_password_reset_path(member.reset_token, member_email: 'wrong')
  	assert_redirected_to root_url
  	# Right email, wrong token
  	get edit_password_reset_path('wrong token', member_email: member.member_email)
  	assert_redirected_to root_url
  	# Right email, right token
  	get edit_password_reset_path(member.reset_token, member_email: member.member_email)
  	assert_template 'password_resets/edit'
  	assert_select "input[name=member_email][type=hidden][value=?]", member.member_email
  	# Invalid password and confirmation.
  	patch password_reset_path(member.reset_token),
  		member_email: member.member_email,
  		member: { password: "foobaz",
  							password_confirmation: "barquux" }
  	assert_select 'div#error_explanation'
  	# Blank password and confirmation.
  	patch password_reset_path(member.reset_token),
  		member_email: member.member_email,
  		member: { password: "foobaz",
                password_confirmation: "foobaz" }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to member
  end

end
