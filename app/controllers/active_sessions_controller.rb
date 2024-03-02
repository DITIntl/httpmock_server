# frozen_string_literal: true

# The ActiveSessionsController is responsible for handling the deletion of active sessions.
class ActiveSessionsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @active_session = current_user.active_sessions.find(params[:id])

    @active_session.destroy

    if current_user
      redirect_to account_path, notice: I18n.t('controllers.active_sessions.deleted')
    else
      forget_active_session
      redirect_to root_path, notice: I18n.t('controllers.active_sessions.signed_out')
    end
  end

  def destroy_all
    forget_active_session
    current_user.active_sessions.destroy_all

    redirect_to root_path, notice: I18n.t('controllers.active_sessions.signed_out')
  end
end
