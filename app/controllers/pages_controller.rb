class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home leaderboard project search_date]

  def home
    city_data = User.group(:city).select('city, SUM(points) AS total_points, COUNT(*) AS user_count')
    city_scores = city_data.map do |data|
      score = data.total_points.to_f / data.user_count
      [data.city, score]
    end.to_h
    top_three_cities = city_scores.sort_by { |_city, score| -score }.first(3)
    @top_three_cities = top_three_cities.map do |city|
      { name: city[0], points: city[1] }
    end
    @top3_schools = School.all.sort_by { |school| school[:points] }.reverse.take 3
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
