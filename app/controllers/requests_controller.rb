# frozen_string_literal: true

# This controller is used to manage requests
class RequestsController < ApplicationController
  before_action :authenticate_user!
end
