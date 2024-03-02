# frozen_string_literal: true

# This controller is responsible for handling the confirmation of user accounts.
class ConfirmationsController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.find_signed(params[:confirmation_token], purpose: :confirm_email)

    if @user.present? && @user.unconfirmed_or_reconfirming?
      if @user.confirm!
        login_user @user
        return redirect_to root_path, notice: I18n.t('controllers.confirmation.confirmed')
      end

      return redirect_to new_confirmation_path, alert: I18n.t('controllers.confirmation.confirmation_server_error')
    end

    redirect_to new_confirmation_path, alert: I18n.t('controllers.confirmation.invalid_token')
  end

  def create
    @user = User.find_by(email: params[:user][:email].downcase)

    if @user.present? && @user.unconfirmed?
      @user.send_confirmation_email!
      return redirect_to root_path, notice: I18n.t('controllers.auth.confirmation_email')
    end

    redirect_to new_confirmation_path, alert: I18n.t('controllers.confirmation.invalid_token')
  end
end
