class SchoolsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :rank_schools, :assign_points

  def index
    @top10_schools = rank_schools.take(10)
  end

  def rank_schools
    School.all.sort_by { |school| school[:points] }.reverse
  end

  def assign_points
    School.all.each do |school|
      school.users.each do |user|
        user.surveys.each do |survey|
          school.increment!(:points, survey.total_value / 10)
        end
      end
    end
  end
end
