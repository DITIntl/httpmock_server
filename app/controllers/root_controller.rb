# frozen_string_literal: true

# This controller is responsible for executing the http mock server
class RootController < ApplicationController
  skip_forgery_protection
  def all
    if request.format == 'text/html' && http_response_headers == {}
      render 'all'
      return
    end

    http_response_headers.each do |key, value|
      response.set_header(key, value)
    end

    render body: http_response_body, status: http_response_status
  end

  private

  def http_response_status
    code = request.headers['response-status']

    return 200 if code.blank?

    code.to_i
  end

  def http_response_body
    request.headers['response-body']
  end

  def http_response_headers
    input = request.headers['response-headers']
    return {} if input.blank?

    headers = {}
    JSON.parse(input).each do |header|
      headers[header.keys[0]] = header[header.keys[0]]
    end

    headers
  end
end
