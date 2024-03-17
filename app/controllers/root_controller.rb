# frozen_string_literal: true

# This controller is responsible for rendering the home page
class RootController < ApplicationController
  def index
    return unless user_signed_in?

    redirect_to projects_path
  end
end
