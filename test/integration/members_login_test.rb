require 'test_helper'

class MembersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@member = members(:bibek)
  end

  test "login with invalid information" do 
  	get login_path
  	assert_template 'sessions/new'
  	post login_path, session: { member_email: "", member_password: "" }
  	assert_template 'sessions/new'
  	assert_not flash.empty?
  	get root_path
  	assert flash.empty?
  end

  test "login with valid information" do 
  	get login_path
  	post login_path, session: { member_email: @member.member_email, member_password: 'password' }
  	assert_redirected_to @member 
  	follow_redirect!
  	assert_template 'members/show'
  	assert_select "a[href=?]", login_path, count: 0
  	assert_select "a[href=?]", logout_path
  	assert_select "a[href=?]", member_path(@member)
  end

  test "login with valid information followed by logout" do 
    get login_path
    post login_path, session: { member_email: @member.member_email, member_password: 'password' }
    assert is_logged_in?
    assert_redirected_to @member 
    follow_redirect!
    assert_template 'members/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", member_path(@member)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a member clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", member_path(@member), count: 0
  end

  test "login with remembering" do 
    log_in_as(@member, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do 
    log_in_as(@member, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
