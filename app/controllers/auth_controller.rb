# frozen_string_literal: true

# This controller is used to authenticate the user
class AuthController < ApplicationController
  before_action :redirect_if_authenticated, only: %i[post_sign_up post_login login sign_up]

  def post_sign_up
    @user = User.new(user_params)

    @user.key = SecureRandom.hex(16)

    if @user.save
      @user.send_confirmation_email!
      redirect_to root_path, notice: I18n.t('controllers.auth.confirmation_email')
    else
      render :sign_up, status: :unprocessable_entity
    end
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def post_login
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user.blank?
      flash.now[:alert] = I18n.t('controllers.auth.invalid_credentials')
      render :login, status: :unprocessable_entity
      return
    end

    if @user.unconfirmed?
      redirect_to new_confirmation_path, alert: I18n.t('controllers.auth.unconfirmed_account')
      return
    end

    if @user.authenticate(params[:user][:password])
      after_login_path = session[:user_return_to] || root_path
      active_session = login_user @user
      remember(active_session) if params[:user][:remember_me] == '1'
      redirect_to after_login_path, notice: I18n.t('controllers.auth.signed_in')
    end

    flash.now[:alert] = I18n.t('controllers.auth.invalid_credentials')
    render :login, status: :unprocessable_entity
  end
  # rubocop:enable all

  def delete_logout
    forget_active_session
    redirect_to root_path, notice: I18n.t('controllers.auth.signed_out')
  end

  def sign_up
    @user = User.new
  end

  def login; end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
