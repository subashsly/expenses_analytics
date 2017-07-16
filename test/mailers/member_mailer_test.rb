require 'test_helper'

class MemberMailerTest < ActionMailer::TestCase

  test "account_activation" do
    # member = Member.create(member_name: "Test User", member_email: "test@example.com",
    #                         password: "foobar", password_confirmation: "foobar" )
    member = members(:bibek)
    member.activation_token = Member.new_token
    mail = MemberMailer.account_activation(member)
    assert_equal "Account Activation", mail.subject
    assert_equal [member.member_email], mail.to
    assert_equal ["noreply@gmail.com"], mail.from
    assert_match member.member_name, mail.body.encoded
    assert_match member.activation_token, mail.body.encoded
    assert_match CGI::escape(member.member_email), mail.body.encoded
  end

  test "password reset" do 
    member = members(:bibek)
    member.reset_token = Member.new_token
    mail = MemberMailer.password_reset(member)
    assert_equal "Password Reset", mail.subject
    assert_equal [member.member_email], mail.to 
    assert_equal ["noreply@gmail.com"], mail.from
    assert_match member.reset_token, mail.body.encoded
    assert_match CGI::escape(member.member_email), mail.body.encoded
  end
end