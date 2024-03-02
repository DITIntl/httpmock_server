# frozen_string_literal: true

# This module is responsible for managing the current user
class Current < ActiveSupport::CurrentAttributes
  attribute :user
end
