# frozen_string_literal: true

# This controller is used to endpoints
class EndpointsController < ApplicationController
  before_action :authenticate_user!

  def new
    @project = current_user.projects.find(params[:project_id])
    @endpoint = @project.endpoints.new
  end

  # rubocop:disable Metrics/AbcSize
  def create
    @project = current_user.projects.find(params[:project_id])
    @endpoint = @project.endpoints.create(endpoint_params)
    @endpoint.user = current_user
    return redirect_to show_project_path(@project.id), notice: I18n.t('controllers.endpoints.created') if @endpoint.save

    flash.now[:alert] = I18n.t('controllers.endpoints.create_error')
    render :new, status: :unprocessable_entity
  end
  # rubocop:enable all

  private

  def endpoint_params
    params.require(:endpoint).permit(
      :request_path,
      :request_method,
      :response_status_code,
      :response_body,
      :response_headers,
      :delay_in_milliseconds,
      :description
    )
  end
end
