# frozen_string_literal: true

# This controller is used to manage requests
class RequestsController < ApplicationController
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def all
    start = Time.now.utc

    @endpoint = Endpoint.fetch_by_request(request)
    if @endpoint.blank?
      return render json: { status: 404, message: I18n.t('controllers.requests.not_found') }, status: :not_found
    end

    headers = http_request_headers
    logger.info "[#{request.url}] request has [#{headers.count}] headers"

    payload = {
      method: request.method,
      url: request.url,
      headers: headers.to_json,
      body: request.body.read,
      user_id: @endpoint.user_id,
      endpoint_id: @endpoint.id,
      project_id: @endpoint.project_id
    }

    StoreHttpRequestJob.perform_later(payload)

    if @endpoint.delay_in_milliseconds.positive? && @endpoint.delay_in_milliseconds >= (Time.now.utc - start) * 1000
      delay = (@endpoint.delay_in_milliseconds - ((Time.now.utc - start) * 1000)) / 1000.0
      logger.info "sleeping for [#{delay}] seconds"
      sleep(delay)
    end

    add_http_response_headers(@endpoint)
    render body: @endpoint.response_body.presence || '', status: @endpoint.response_status_code
  end
  # rubocop:enable all

  private

  def add_http_response_headers(endpoint)
    return if endpoint.response_headers.blank?

    JSON.parse(endpoint.response_headers).each do |key, value|
      response.set_header(key, value)
    end
  end

  def http_request_headers
    headers = []
    request.headers.each do |key, value|
      headers.push({ key => value }) if key.start_with? 'HTTP'
    end
  end
end
