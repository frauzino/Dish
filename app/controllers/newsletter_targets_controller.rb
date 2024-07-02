class NewsletterTargetsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ create ]
  before_action :set_newsletter_target, only: %i[ destroy ]
  before_action :authenticate_admin, only: %i[ index destroy ]

  # GET /newsletter_targets
  def index
    @newsletter_targets = NewsletterTarget.all
  end

  # GET /newsletter_targets/new
  def new
    @newsletter_target = NewsletterTarget.new
  end

  # POST /newsletter_targets
  def create
    @newsletter_target = NewsletterTarget.new(newsletter_target_params)

    if @newsletter_target.save
      render turbo_stream: turbo_stream.replace('newsletter-signup-form', partial: 'newsletter_targets/signup_thank_you')
    else
      render turbo_stream: turbo_stream.replace('newsletter-signup-form', partial: 'newsletter_targets/form', locals: { newsletter_target: @newsletter_target })
    end
  end

  # DELETE /newsletter_targets/1
  def destroy
    @newsletter_target.destroy
    redirect_to newsletter_targets_url, notice: "Newsletter target was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_newsletter_target
    @newsletter_target = NewsletterTarget.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def newsletter_target_params
    params.require(:newsletter_target).permit(:email)
  end

  def authenticate_admin
    redirect_to root_path, alert: 'You are not authorized to perform this action' unless current_user.is_admin?
  end
end
