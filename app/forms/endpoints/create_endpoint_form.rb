# frozen_string_literal: true

# This renders a form for the user to create a new project
class CreateEndpointForm < ApplicationForm
  # rubocop:disable Metrics/BlockLength
  form do |fields|
    fields.select_list(
      name: :request_method,
      required: true,
      caption: I18n.t('forms.endpoint.request_method_caption'),
      label: I18n.t('forms.endpoint.request_method')
    ) do |c|
      c.option(value: 'GET', label: 'GET')
      c.option(value: 'POST', label: 'POST')
      c.option(value: 'PUT', label: 'PUT')
      c.option(value: 'PATCH', label: 'PATCH')
      c.option(value: 'DELETE', label: 'DELETE')
      c.option(value: 'ANY', label: 'ANY')
    end
    fields.text_field(
      name: :request_path,
      required: true,
      placeholder: 'e.g /v1/posts/1',
      caption: I18n.t('forms.endpoint.request_path_caption'),
      label: I18n.t('forms.endpoint.request_path')
    )
    fields.text_field(
      name: :response_status_code,
      type: :number,
      required: true,
      placeholder: 'e.g 200',
      caption: I18n.t('forms.endpoint.response_status_code_caption'),
      label: I18n.t('forms.endpoint.response_status_code')
    )
    fields.text_area(
      name: :response_body,
      rows: 15,
      placeholder: I18n.t('forms.endpoint.response_body_placeholder'),
      caption: I18n.t('forms.endpoint.response_body_caption'),
      label: I18n.t('forms.endpoint.response_body')
    )
    fields.text_area(
      name: :response_headers,
      placeholder: I18n.t('forms.endpoint.response_headers_placeholder'),
      label: I18n.t('forms.endpoint.response_headers'),
      caption: I18n.t('forms.endpoint.response_headers_caption')
    )
    fields.text_field(
      name: :delay_in_milliseconds,
      type: :number,
      placeholder: '100',
      caption: I18n.t('forms.endpoint.delay_in_milliseconds_caption'),
      label: I18n.t('forms.endpoint.delay_in_milliseconds')
    )
    fields.text_area(
      name: :description,
      placeholder: I18n.t('forms.endpoint.description_placeholder'),
      caption: I18n.t('forms.endpoint.description_caption'),
      label: I18n.t('forms.endpoint.description')
    )
    fields.submit(
      label: I18n.t('forms.endpoint.create'),
      scheme: :primary,
      name: 'submit',
      class: 'mt-2'
    )
  end
  # rubocop:enable all
end
