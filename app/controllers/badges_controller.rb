class BadgesController < ApplicationController

  def index
    @badges = Badge.all
  end

  private

  def set_badge
    @badge = Badge.find(params[:id])
  end
end
