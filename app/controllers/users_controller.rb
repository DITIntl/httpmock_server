# frozen_string_literal: true

# This controller is responsible for managing user accounts
class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit destroy update]

  def edit
    @user = current_user
    @active_sessions = @user.active_sessions.order(created_at: :desc)
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def update
    @user = current_user
    @active_sessions = @user.active_sessions.order(created_at: :desc)

    unless @user.authenticate(params[:user][:current_password])
      flash.now[:error] = I18n.t('controllers.users.invalid_password')
      return render :edit, status: :unprocessable_entity
    end

    render :edit, status: :unprocessable_entity unless @user.update(update_user_params)

    if params[:user][:unconfirmed_email].present?
      @user.send_confirmation_email!
      return redirect_to root_path, notice: I18n.t('controllers.auth.confirmation_email')
    end

    redirect_to root_path, notice: I18n.t('controllers.users.updated')
  end
  # rubocop:enable all

  def destroy
    current_user.destroy
    reset_session
    redirect_to root_path, notice: I18n.t('controllers.users.updated')
  end

  private

  def update_user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation, :unconfirmed_email)
  end
end
