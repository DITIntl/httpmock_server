# frozen_string_literal: true

# This job is used to store HTTP requests in the database in the background
class StoreHttpRequestJob < ApplicationJob
  queue_as :urgent

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Layout/LineLength
  def perform(request)
    @request = Request.create(
      method: request[:method],
      url: request[:url],
      headers: request[:headers],
      body: request[:body],
      user_id: request[:user_id],
      ip_address: request[:ip_address],
      endpoint_id: request[:endpoint_id],
      project_id: request[:project_id]
    )

    unless @request.save
      logger.error "could not save [#{request[:method]}] request for endpoint [#{request[:endpoint_id]}] and user [#{request[:user_id]}]"
    end

    logger.info "saved [#{request[:method]}] [#{request[:url]}] for endpoint [#{request[:endpoint_id]}] and user [#{request[:user_id]}]"
  end
  # rubocop:enable all
end
