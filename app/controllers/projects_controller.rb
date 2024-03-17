# frozen_string_literal: true

# This controller is used to manage user projects
class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.projects
    return unless @projects.count.zero?

    redirect_to new_projects_path, notice: I18n.t('controllers.projects.no_project')
  end

  def show
    @project = current_user.projects.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def delete
    @project = current_user.projects.find(params[:id])
    @project.destroy
    redirect_to index_projects_path, notice: I18n.t('controllers.projects.deleted')
  end

  def create
    @project = current_user.projects.create(project_params)
    return redirect_to new_projects_path, notice: I18n.t('controllers.projects.created') if @project.save

    flash.now[:alert] = I18n.t('controllers.projects.create_error')
    render :new, status: :unprocessable_entity
  end

  def patch
    @project = current_user.projects.find(params[:id])

    if @project.update(project_params)
      return redirect_to show_projects_path(@project.id), notice: I18n.t('controllers.projects.updated')
    end

    flash.now[:alert] = I18n.t('controllers.projects.update_error')
    render :edit, status: :unprocessable_entity
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
