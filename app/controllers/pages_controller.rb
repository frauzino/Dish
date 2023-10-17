class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index survey leaderboard project]

  def index
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
