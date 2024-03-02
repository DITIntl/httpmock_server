# frozen_string_literal: true

# This is the base controller for the application
class ApplicationController < ActionController::Base
  include Authentication
end
