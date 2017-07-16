require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  
  def setup
    @member = members(:bibek)
    @other_member = members(:kedar)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  # test "should get index" do
  #   get :index
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get :edit
  #   assert_response :success
  # end

  # test "should get update" do
  #   get :update
  #   assert_response :success
  # end

  # test "should get destroy" do
  #   get :destroy
  #   assert_response :success
  # end

  test "should redirect index when not logged in" do 
    get :index
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @member
    assert_redirected_to login_url 
  end

  test "should redirect update when not logged in" do 
    patch :update, id: @member, member: { member_name: @member.member_name, member_email: @member.member_email }
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong member" do 
    log_in_as(@other_member)
    get :edit, id: @member
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as a wrong member" do 
    log_in_as(@other_member)
    patch :update, id: @member, member: { member_name: @member.member_name, member_email: @member.member_email }
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in"  do 
    assert_no_difference 'Member.count' do 
      delete :destroy, id: @member
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do 
    log_in_as(@other_member)
    assert_no_difference 'Member.count' do 
      delete :destroy, id: @member
    end
    assert_redirected_to root_url
  end
end
