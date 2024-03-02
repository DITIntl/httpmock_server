# frozen_string_literal: true

# The PasswordsController is responsible for handling the reset of user passwords.
class PasswordsController < ApplicationController
  before_action :redirect_if_authenticated

  def new; end

  def edit
    @user = User.find_signed(params[:password_reset_token], purpose: :reset_password)
    if @user.present? && @user.unconfirmed?
      redirect_to new_confirmation_path, alert: I18n.t('controllers.passwords.confirm_email')
    elsif @user.nil?
      redirect_to new_password_path, alert: I18n.t('controllers.passwords.invalid_token')
    end
  end

  # rubocop:disable Metrics/AbcSize
  def create
    @user = User.find_by(email: params[:user][:email].downcase)
    return redirect_to root_path, notice: I18n.t('controllers.passwords.instructions_email') if @user.blank?

    if @user.confirmed?
      @user.send_password_reset_email!
      return redirect_to root_path, notice: I18n.t('controllers.passwords.instructions_email')
    end

    redirect_to new_confirmation_path, alert: I18n.t('controllers.passwords.confirm_email')
  end
  # rubocop:enable all

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def update
    @user = User.find_signed(params[:password_reset_token], purpose: :reset_password)
    if @user.blank?
      flash.now[:alert] = I18n.t('controllers.passwords.invalid_token')
      render :new, status: :unprocessable_entity
    end

    return redirect_to new_confirmation_path, alert: I18n.t('controllers.passwords.confirm_email') if @user.unconfirmed?

    if @user.update(password_params)
      return redirect_to auth_login_path, notice: I18n.t('controllers.passwords.reset_successful')
    end

    flash.now[:alert] = @user.errors.full_messages.to_sentence
    render :edit, status: :unprocessable_entity
  end
  # rubocop:enable all

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
