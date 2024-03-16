# frozen_string_literal: true

# This controller is used to manage user projects
class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.projects
    return unless @projects.count.zero?

    redirect_to projects_new_path, notice: I18n.t('controllers.projects.no_project')
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.create(project_params)
    return redirect_to projects_path, notice: I18n.t('controllers.projects.created') if @project.save

    render :new, status: :unprocessable_entity
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
