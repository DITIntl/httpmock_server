# frozen_string_literal: true

# This renders the new user sign up form with name, email, password, and password confirmation fields.
class SignUpForm < ApplicationForm
  form do |sign_up|
    sign_up.text_field(name: :name, label: I18n.t('forms.auth.name'), class: 'mb-2')
    sign_up.text_field(name: :email, label: I18n.t('forms.auth.email'), class: 'mb-2')
    sign_up.text_field(name: :password, type: 'password', class: 'mb-2', label: I18n.t('forms.auth.password'))
    sign_up.text_field(name: :password_confirmation, type: 'password', class: 'mb-2',
                       label: I18n.t('forms.auth.password_confirmation'))
    sign_up.submit(label: I18n.t('forms.auth.sign_up'), class: 'Button--primary', size: :large, name: 'submit')
  end
end
