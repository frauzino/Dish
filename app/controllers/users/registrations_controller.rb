# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :school_names, only: %i[new update create]
  after_action :generate_referral_code, only: %i[create]
  after_action :check_referrals, only: %i[create]

  # POST /resource
  # def create
  #   @school = set_school(params[:user][:school])
  #   params[:user][:school] = @school
  #   super
  #   resource.school = @school
  #   if resource.save
  #     redirect_to root_path
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def create
    new_params = sign_up_params
    new_params['school'] = set_school(sign_up_params['school'])
    build_resource(new_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: root_path
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def generate_referral_code
    @referral = Referral.new(user: resource)
    @referral.code = SecureRandom.alphanumeric(8)
    @referral.save!
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

  def school_names
    @school_names = Scraper.new.school_scraper
  end

  def set_school(name)
    return School.find_by(name:) if School.find_by(name:)

    School.create(name:)
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

  # def update
  #   resource.update(configure_account_update_params)
  #   redirect_to account_path
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

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[attribute username photo first_name last_name gender])
  end

  def after_update_path_for(resource)
    account_path(resource)
  end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:account_update, keys: [])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
