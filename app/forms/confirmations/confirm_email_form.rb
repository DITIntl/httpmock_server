# frozen_string_literal: true

# This renders a form for the user to confirm their email
class ConfirmEmailForm < ApplicationForm
  form do |login|
    login.text_field(name: :email, label: I18n.t('forms.auth.email'), class: 'mb-2')
    login.submit(label: I18n.t('forms.confirmations.confirm'), class: 'Button--primary mt-2', size: :large,
                 name: 'submit')
  end
end
