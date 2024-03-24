# frozen_string_literal: true

# This controller is used to endpoints
class EndpointsController < ApplicationController
  before_action :authenticate_user!

  def show
    @project = current_user.projects.find(params[:project_id])
    @endpoint = @project.endpoints.find(params[:id])
    @requests = @endpoint.requests.sort_by(&:updated_at).reverse
  end

  def new
    @project = current_user.projects.find(params[:project_id])
    @endpoint = @project.endpoints.new
  end

  def edit
    @project = current_user.projects.find(params[:project_id])
    @endpoint = @project.endpoints.find(params[:id])
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

  # rubocop:disable Metrics/AbcSize
  def update
    @project = current_user.projects.find(params[:project_id])
    @endpoint = @project.endpoints.find(params[:id])
    @endpoint.update(endpoint_params)
    return redirect_to show_project_path(@project.id), notice: I18n.t('controllers.endpoints.updated') if @endpoint.save

    flash.now[:alert] = I18n.t('controllers.endpoints.update_error')
    render :edit, status: :unprocessable_entity
  end
  # rubocop:enable all

  # rubocop:disable Metrics/AbcSize
  def delete
    @project = current_user.projects.find(params[:project_id])
    @endpoint = @project.endpoints.find(params[:id])
    if @endpoint.destroy
      return redirect_to show_project_path(@project.id), notice: I18n.t('controllers.endpoints.deleted')
    end

    flash[:alert] = I18n.t('controllers.endpoints.delete_error')
    redirect_to show_project_path(@project.id)
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
