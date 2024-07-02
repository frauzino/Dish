class PagesController < ApplicationController
  before_action :authenticate_user!, only: %i[account survey]

  def home
    @newsletter_target = NewsletterTarget.new
  end

  def survey
  end

  def leaderboard
  end

  def about_us
  end

  def copyright
  end

  def privacy
  end

  def legal
  end

  def account
  end
end
