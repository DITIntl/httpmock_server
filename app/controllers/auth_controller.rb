# frozen_string_literal: true

# This controller is used to authenticate the user
class AuthController < ApplicationController
  before_action :redirect_if_authenticated, only: %i[post_sign_up post_login login sign_up]

  def post_sign_up
    @user = User.new(user_params)
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
      return render :login, status: :unprocessable_entity
    end

    if @user.unconfirmed?
      return redirect_to new_confirmation_path, alert: I18n.t('controllers.auth.unconfirmed_account')
    end

    if @user.authenticate(params[:user][:password])
      after_login_path = session[:user_return_to] || index_project_path
      active_session = login_user @user
      remember(active_session) if params[:user][:remember_me] == '1'
      return redirect_to after_login_path, notice: I18n.t('controllers.auth.signed_in')
    end

    flash.now[:alert] = I18n.t('controllers.auth.invalid_credentials')
    render :login, status: :unprocessable_entity
  end
  # rubocop:enable all

  def delete_logout
    forget_active_session
    logout
    redirect_to root_path, notice: I18n.t('controllers.auth.signed_out')
  end

  def sign_up
    @user = User.new
  end

  def login; end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
