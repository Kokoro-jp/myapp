# frozen_string_literal: true

class Stores::PasswordsController < Devise::PasswordsController
  before_action :ensure_normal_store, only: :create

  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  def ensure_normal_store
    return unless params[:store][:email].downcase == Store::STORE_EMAIL

    redirect_to new_store_sessions_path, alert: 'ゲストユーザー(店舗)のパスワード再設定はできません。'
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
