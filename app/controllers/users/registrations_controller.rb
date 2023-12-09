# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  after_action :generate_referral_code, only: %i[create]
  after_action :check_referrals, only: %i[create]

  # POST /resource
  # def create
  #   super
  #   generate_referral_code
  #   check_referrals
  # end

  def generate_referral_code
    @referral = Referral.new(user: resource)
    @referral.code = SecureRandom.alphanumeric(8) until @referral.save
  end

  def check_referrals
    # return unless current_user.referral_input
    return unless resource.referral_input

    referral_in = resource.referral_input
    reference_user = User.joins(:referral).find_by(referral: { code: referral_in })
    return unless reference_user

    reference_user.increment!(:points, 10)
    resource.increment!(:points, 5)
    Referral.find_by(code: referral_in).increment!(:uses_count)
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end


  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
