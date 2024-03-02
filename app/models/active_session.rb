# frozen_string_literal: true

# This model is responsible for managing the active sessions
class ActiveSession < ApplicationRecord
  belongs_to :user
  has_secure_token :remember_token
end
