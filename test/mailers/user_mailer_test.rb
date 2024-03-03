# frozen_string_literal: true

require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'confirmation' do
    mail = UserMailer.confirmation User.new, 'confirmation_token'
    assert_equal I18n.t('mailers.user.confirmation.subject'), mail.subject
    assert_equal 'support@httpmock.dev', mail.from
  end
end
