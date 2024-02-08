class ResultsController < ApplicationController

  def create(survey)
    Result.new(image: set_image(survey), survey:).save
  end

  def set_image(survey)
    value = survey.total_value
    max_value = set_value(survey)
    gender = set_gender(survey)

    case gender
    when 'Male'
      image = set_image_male(value, max_value)
    when 'Female'
      image = set_image_female(value, max_value)
    else
      image = set_image_other(value, max_value)
    end
    return image
  end

  def set_gender(survey)
    if user_signed_in?
      sq = survey.survey_questions.joins(:question).find_by(question: { body: 'Was the person you went on a date with...' })
      return sq.answer
    end
  end

  def set_value(survey)
    max_value = 0
    survey.survey_questions.each do |sq|
      max_value += sq.question.options.maximum('value')
    end
    return max_value
  end

  def set_image_male(value, max_value)
    case value
    when 0..(max_value * 0.25)
      image = 'freddy.svg'
    when (max_value * 0.25 + 1)..(max_value / 2)
      image = 'ogre.svg'
    when (max_value / 2 + 1)..(max_value * 0.75)
      image = 'lion.svg'
    else
      image = 'prince.svg'
    end
    return image
  end

  def set_image_female(value, max_value)
    case value
    when 0..(max_value * 0.25)
      image = 'witch.svg'
    when (max_value * 0.25 + 1)..(max_value / 2)
      image = 'cow.svg'
    when (max_value / 2 + 1)..(max_value * 0.75)
      image = 'gold-digger.svg'
    else
      image = 'princess.svg'
    end
    return image
  end

  def set_image_other(value, max_value)
    case value
    when 0..(max_value * 0.25)
      image = 'pig.svg'
    when (max_value * 0.25 + 1)..(max_value / 2)
      image = 'cow.svg'
    when (max_value / 2 + 1)..(max_value * 0.75)
      image = 'panda.svg'
    else
      image = 'rooster.svg'
    end
    return image
  end
end
