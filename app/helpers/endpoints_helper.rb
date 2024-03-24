# frozen_string_literal: true

# This helper is used to render the endpoints
module EndpointsHelper
  # rubocop:disable Metrics/MethodLength
  def request_method_scheme(method)
    case method
    when 'GET'
      :info
    when 'POST'
      :success
    when 'PUT'
      :attention
    when 'PATCH'
      :severe
    when 'DELETE'
      :danger
    else
      :done
    end
  end
  # rubocop:enable all
end
