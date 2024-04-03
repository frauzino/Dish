class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index search_date]

  def index
    @top10_users = rank_users.take(10)
    @top10_schools = index_schools.take(10)
  end

  def show
    @user = current_user
    check_survey_badges
    check_dates_badges
    check_misc_badges
    check_friends_badges
    check_searches_badges
    @referral_count = Survey.where(reference: @user.referral.code).where.not(user: @user).count
  end

  def rank_users
    User.all.sort_by { |user| user[:points] }.reverse
  end

  def index_schools
    schools_controller = SchoolsController.new
    schools_controller.request = request
    schools_controller.response = response
    schools_controller.index
  end

  def search_date
    @user = current_user
  end

  # Methods pertaining to user's search_date_accessed array of timestamps. for ensuring access to Search Date feature

  Warden::Manager.after_set_user do |user, _auth, _opts|
    user.search_date_accessed.each do |date|
      if ((DateTime.now.to_time - date.to_time) / 1.hours) > 1
        user.search_date_accessed.delete(date)
        user.save
      end
    end
  end

  def update_access
    # current_user.search_date_accessed_will_change!
    current_user.search_date_accessed << DateTime.now.to_s
    current_user.search_date_queries_count += 1
    current_user.save
    respond_to do |format|
      format.json { render json: current_user }
    end
  end

  # Badge Methods

  def check_survey_badges
    create_badge('First Survey') if @user.surveys.count >= 1
    create_badge('5x Surveys') if @user.surveys.count >= 5
    create_badge('10x Surveys') if @user.surveys.count >= 10
  end

  def check_dates_badges
    if @user.gender == 'Male' && Survey.where(user: @user, survey_questions: SurveyQuestion.where(answer: 'Male')).exists?
      create_badge('Gay Date')
    end
    if @user.gender == 'Female' && Survey.where(user: @user, survey_questions: SurveyQuestion.where(answer: 'Female')).exists?
      create_badge('Lesbian Date')
    end
    if @user.gender == 'Male' && Survey.where(user: @user, survey_questions: SurveyQuestion.where(answer: 'Female')).exists?
      create_badge('Straight Date')
    end
    if @user.gender == 'Nonbinary' || @user.gender == 'Other' && Survey.where(user: @user, survey_questions: SurveyQuestion.where(answer: 'Nonbinary')).exists?
      create_badge('Queer Date')
    end
    if @user.gender == 'Nonbinary' || @user.gender == 'Other' && Survey.where(user: @user, survey_questions: SurveyQuestion.where(answer: 'Female')).exists?
      create_badge('Queer x Female Date')
    elsif @user.gender == 'Female' && Survey.where(user: @user, survey_questions: SurveyQuestion.where(answer: 'Nonbinary')).exists?
      create_badge('Queer x Female Date')
    end
    if @user.gender == 'Nonbinary' || @user.gender == 'Other' && Survey.where(user: @user, survey_questions: SurveyQuestion.where(answer: 'Male')).exists?
      create_badge('Queer x Male Date')
    elsif @user.gender == 'Male' && Survey.where(user: @user, survey_questions: SurveyQuestion.where(answer: 'Nonbinary')).exists?
      create_badge('Queer x Male Date')
    end
    # if @user.gender == 'Male' && @user.badges.where(name: ['Gay Date', 'Straight Date', 'Queer x Male Date'])
    #   create_badge('Pansexual')
    # elsif @user.gender == 'Female' && @user.badges.where(name: ['Lesbian Date', 'Straight Date', 'Queer x Female Date'])
    #   create_badge('Pansexual')
    # elsif @user.gender == 'Nonbinary' || @user.gender == 'Other' && @user.badges.where(name: ['Queer Date', 'Queer x Male Date', 'Queer x Female Date'])
    #   create_badge('Pansexual')
    # end
  end

  def check_misc_badges
    create_badge('First Place') if rank_users.take(1).first == @user
    create_badge('Safest School') if index_schools.take(1).first == @user.school
    create_badge('Profile Photo') if @user.photo.key
  end

  def check_friends_badges
    create_badge('First Friend') if @user.referral.uses_count >= 1
    create_badge('5x Friends') if @user.referral.uses_count >= 5
    create_badge('10x Friends') if @user.referral.uses_count >= 10
  end

  def check_searches_badges
    create_badge('First Search') if @user.search_date_queries_count >= 1
    create_badge('5x Searches') if @user.search_date_queries_count >= 5
    create_badge('10x Searches') if @user.search_date_queries_count >= 10
  end

  def create_badge(name)
    UserBadge.create(user: current_user, badge: Badge.find_by(name:))
  end
end
