# frozen_string_literal: true

# This renders a form for the user to create a new project
class EditProjectForm < ApplicationForm
  form do |edit|
    edit.text_field(name: :name, label: I18n.t('forms.project.name'), class: 'mb-2')
    edit.text_area(name: :description, label: I18n.t('forms.project.description'), class: 'mb-2')
    edit.submit(label: I18n.t('forms.project.update'), scheme: :primary, class: 'Button--primary mt-2', size: :large,
                name: 'submit')
  end
end
