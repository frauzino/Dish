module ApplicationHelper
  def show_badges
    @badges = Badge.all
  end
end
