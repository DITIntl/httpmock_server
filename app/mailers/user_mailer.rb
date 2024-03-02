# frozen_string_literal: true

# This mailer is responsible for sending emails to users
class UserMailer < ApplicationMailer
  default from: User::MAILER_FROM_EMAIL
  def confirmation(user, confirmation_token)
    @user = user
    @confirmation_token = confirmation_token

    mail to: @user.confirmable_email, subject: I18n.t('mailers.user.confirmation.subject')
  end

  def password_reset(user, password_reset_token)
    @user = user
    @password_reset_token = password_reset_token

    mail to: @user.email, subject: I18n.t('mailers.user.password_reset.subject')
  end
end
