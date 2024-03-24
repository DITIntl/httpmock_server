# frozen_string_literal: true

# This model manages http requests to the various endpoints
class Request < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :endpoint
end
