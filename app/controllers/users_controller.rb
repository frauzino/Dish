class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @top10_users = rank_users.take(10)
  end

  def show
    @user = current_user
    check_survey_badges
    check_dates_badges
    check_misc_badges
    # check_friends_badges
  end

  def rank_users
    User.all.sort_by { |user| user[:points] }.reverse
  end

  def check_survey_badges
    create_badge('First Survey') if @user.surveys.count >= 1
    create_badge('5x Surveys') if @user.surveys.count >= 5
    create_badge('10x Surveys') if @user.surveys.count >= 10
  end

  def check_dates_badges
    if @user.gender == 'Male' && Survey.where(user: @user, survey_questions: SurveyQuestion.where(answer: 'yes')).exists?
      create_badge('Gay Date')
    end
    if @user.gender == 'Female' && Survey.where(user: @user, survey_questions: SurveyQuestion.where(answer: 'yes')).exists?
      create_badge('Lesbian Date')
    end
    if @user.gender == 'Male' && Survey.where(user: @user, survey_questions: SurveyQuestion.where(answer: 'no')).exists?
      create_badge('Straight Date')
    end
    if @user.gender == 'Nonbinary' || @user.gender == 'Other' && Survey.where(user: @user, survey_questions: SurveyQuestion.where(answer: 'no')).exists?
      create_badge('Queer Date')
    end
    if @user.gender == 'Nonbinary' || @user.gender == 'Other' && Survey.where(user: @user, survey_questions: SurveyQuestion.where(answer: 'no')).exists?
      create_badge('Queer x Female Date')
    end
    if @user.gender == 'Nonbinary' || @user.gender == 'Other' && Survey.where(user: @user, survey_questions: SurveyQuestion.where(answer: 'no')).exists?
      create_badge('Queer x Male Date')
    end
    # create_badge('Pansexual') if @user.surveys.count >= 10
  end

  def check_misc_badges
    create_badge('First Place') if rank_users.take(1).first == @user
    create_badge('Profile Photo') if @user.image
  end

  # def check_friends_badges
  #   create_badge('First Friend') if @user.surveys.count >= 1
  #   create_badge('5x Friends') if @user.surveys.count >= 5
  #   create_badge('10x Friends') if @user.surveys.count >= 10
  # end

  def create_badge(name)
    UserBadge.create(user: current_user, badge: Badge.find_by(name:))
  end
end
