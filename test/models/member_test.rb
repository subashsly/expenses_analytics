require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@member = Member.new(member_name: "Example User", member_email: "user@example.com",
  												member_country: "Nepal" ,password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do 
  	assert @member.valid?
  end

  test "member name should be present" do 
  	@member.member_name = " "
  	assert_not @member.valid?
  end

  test "member email should be present" do 
  	@member.member_email = " "
  	assert_not @member.valid?
  end

  test "member name should not be too long" do 
  	@member.member_name = "a" * 51
  	assert_not @member.valid?
  end

  test "member email should not be too long" do 
  	@member.member_email = "a" * 256
  	assert_not @member.valid?
  end

  test "member email validation should accept valid addresses" do 
  	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
  	valid_addresses.each do |valid_address|
  		@member.member_email = valid_address
  		assert @member.valid?, "#{valid_address.inspect} should be valid"
  	end
  end

  test "member email validation should reject invalid addresses" do 
  	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_bz.com foo@bar+baz.com]
  	invalid_addresses.each do |invalid_address|
  		@member.member_email = invalid_address
  		assert_not @member.valid?, "#{invalid_address.inspect} should be invalid"
  	end
  end

  test "email address should be unique" do 
  	duplicate_member = @member.dup
  	duplicate_member.member_email = @member.member_email.upcase
  	@member.save
  	assert_not duplicate_member.valid?
  end

  test "member password should have a minimun length" do 
  	@member.password = @member.password_confirmation = "a" * 5
  	assert_not @member.valid?
  end

  test "authenticated? should return false for a member with nil digest" do 
    assert_not @member.authenticated?(:remember, '')
  end

  test "associated incomes should be destroyed" do 
    @member.save
    @member.incomes.create!(title: "First salary", description: "This is first Salary.", amount: 1200, date: "2015/12/12")
    assert_difference 'Income.count', -1 do 
      @member.destroy
    end 
  end
end
