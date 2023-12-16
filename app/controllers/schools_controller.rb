class SchoolsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :assign_points, only: %i[index]

  def index
    @top10_schools = rank_schools.take(10)
  end

  def rank_schools
    @schools = assign_score
    @schools.sort_by { |school| school[:points] }.reverse
  end

  def assign_score
    School.all.each do |school|
      school.users.each do |user|
        user.surveys.each do |survey|
          max_value = 0
          survey.survey_questions.each do |sq|
            max_value += sq.question.options.maximum('value')
          end
          score = (survey.total_value + school.points) / (max_value + 100.0) * 100
          school.update(points: score.round(1))
        end
      end
    end
  end
end
