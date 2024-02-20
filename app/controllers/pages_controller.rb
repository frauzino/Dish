class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home leaderboard project search_date]

  def home
  end

  def survey
  end

  def leaderboard
  end

  def project
  end

  def account
  end
end
