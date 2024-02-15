# frozen_string_literal: true

# This controller mocks a simple http status server with some delay
class StatusController < ApplicationController
  skip_forgery_protection
  def all
    sleep(http_response_delay / 1000.0)

    payload = {
      'status' => params[:status_code].to_i,
      'delay' => "#{http_response_delay}ms"
    }

    render json: payload, status: params[:status_code].to_i
  end

  private

  def http_response_delay
    return 0 if params[:delay].blank?

    [params[:delay].to_i || 0, 10_000].min
  end
end
