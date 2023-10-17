class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def can_administer?
    current_user.try(:admin?)
  end
end
