class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @users = User.all.sort_by { |user| user[:points] }.reverse
    @top10_users = @users.take(10)
  end
end
