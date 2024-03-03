# frozen_string_literal: true

# This renders the login form with email, password, and remember me fields.
class LoginForm < ApplicationForm
  form do |login|
    login.text_field(name: :email, label: I18n.t('forms.auth.email'), class: 'mb-2')
    login.text_field(name: :password, type: 'password', class: 'mb-2', label: I18n.t('forms.auth.password'))
    login.check_box(
      name: :remember_me,
      label: I18n.t('forms.auth.remember_me')
    )
    login.submit(label: I18n.t('forms.auth.login'), class: 'Button--primary mt-2', size: :large, name: 'submit')
  end
end
