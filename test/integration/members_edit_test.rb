require 'test_helper'

class MembersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@member = members(:bibek)
  end

  test "unsuccessful edit" do 
  	log_in_as(@member)
  	get edit_member_path(@member)
  	assert_template 'members/edit'
  	patch member_path(@member), member: { member_name: '',
  																			member_email: 'foo@invalid.com',
  																			password: 'foo',
  																			password_confirmation: 'bar' }
 		assert_template 'members/edit'
  end

  test "successful edit with friendly forwarding" do 
  	get edit_member_path(@member)
  	log_in_as(@member)
  	assert_redirected_to edit_member_path(@member)
  	member_name = "Foo Bar"
  	member_email = "foo@bar.com"
  	patch member_path(@member), member: { member_name: member_name,
  																				member_email: member_email,
  																				password: "foobar",
  																				password_confirmation: "foobar" }
  	asset_not flash.empty?
  	assert_redirected_to @member
  	@member.reload
  	assert_equal @member.member_name, member_name
  	assert_equal @member.member_email, member_email
  end
end
