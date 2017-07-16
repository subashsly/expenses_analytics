class MemberMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.member_mailer.account_activation.subject
  #
  def account_activation(member)
    @member = member
    mail to: member.member_email, subject: "Account Activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.member_mailer.password_reset.subject
  #
  def password_reset(member)
    @member = member
    mail to: member.member_email, subject: "Password Reset"
  end
end