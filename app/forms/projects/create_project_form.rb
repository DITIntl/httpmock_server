# frozen_string_literal: true

# This renders a form for the user to create a new project
class CreateProjectForm < ApplicationForm
  form do |create|
    create.text_field(name: :name, label: I18n.t('forms.project.name'), class: 'mb-2')
    create.text_area(name: :description, label: I18n.t('forms.project.description'), class: 'mb-2')
    create.submit(label: I18n.t('forms.project.create'), size: :large, name: 'submit')
  end
end
