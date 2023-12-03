require 'faker'

puts 'cleaning database'

SurveyQuestion.destroy_all
UserBadge.destroy_all

Option.destroy_all
Survey.destroy_all
User.destroy_all
Question.destroy_all
Badge.destroy_all

puts 'Database clean'

puts 'Creating admin user'

User.create(
  email: 'a@a.a',
  username: 'Test User',
  password: '123456',
  first_name: 'Richard',
  last_name: 'Smith',
  is_admin: true,
  gender: 'Male',
  points: 50
)
User.create(
  email: 'b@b.b',
  username: 'Another Test',
  password: '123456',
  first_name: 'Bob',
  last_name: 'jones',
  is_admin: false,
  gender: 'Female',
  points: 109
)

puts 'Admin created email: a@a.a passcode: 123456'
puts 'second test user created. email: b@b.b passcode 123456'

puts 'Creating questions'

10.times do
  Question.create(
    body: Faker::Quotes::Shakespeare.unique.romeo_and_juliet_quote
  )
  Option.create(
    body: 'yes',
    question: Question.last
  )
  Option.create(
    body: 'no',
    question: Question.last
  )
end

puts 'Created questions'

puts 'creating all the badges'

badge_unlock_reqs = [
  'Have your referral code used by 5 friends',
  'Complete 5 questionnaires',
  'Have your referral code used by 10 friends',
  'Complete 10 questionnaires',
  'Complete your first questionnaire',
  'Have one friend use your referral code',
  'As a male, go on one date with another male',
  'As a female, go on one date with another female',
  'Go on at least one date with the someone of the opposite gender, your same gender, and queer/non gendered.',
  'upload a photo to your profile',
  'Go on a date where one person is queer while the other is female',
  'Go on a date where one person is queer while the other is male',
  'Go on a date where both people are queer',
  'Go on a date where one person is male while the other is female',
  'Achieve rank one on the leaderboard'
]

Badge.create(
  name: '5x Friends',
  unlock_reqs: badge_unlock_reqs[0],
  icon: '5x_friends_badge.svg'
)

Badge.create(
  name: '5x Surveys',
  unlock_reqs: badge_unlock_reqs[1],
  icon: '5x_survey_badge.svg'
)
Badge.create(
  name: '10x Friends',
  unlock_reqs: badge_unlock_reqs[2],
  icon: '10x_friends_badge.svg'
)

Badge.create(
  name: '10x Surveys',
  unlock_reqs: badge_unlock_reqs[3],
  icon: '10x_survey_badge.svg'
)

Badge.create(
  name: 'First Survey',
  unlock_reqs: badge_unlock_reqs[4],
  icon: 'checkmark_badge.svg'
)

Badge.create(
  name: 'First Friend',
  unlock_reqs: badge_unlock_reqs[5],
  icon: 'friends_badge.svg'
)

Badge.create(
  name: 'Gay Date',
  unlock_reqs: badge_unlock_reqs[6],
  icon: 'gay_badge.svg'
)

Badge.create(
  name: 'Lesbian Date',
  unlock_reqs: badge_unlock_reqs[7],
  icon: 'lesbian_badge.svg'
)

Badge.create(
  name: 'Pansexual',
  unlock_reqs: badge_unlock_reqs[8],
  icon: 'pan_badge.svg'
)

Badge.create(
  name: 'Profile Photo',
  unlock_reqs: badge_unlock_reqs[9],
  icon: 'profile_photo_badge.svg'
)

Badge.create(
  name: 'Queer x Female Date',
  unlock_reqs: badge_unlock_reqs[10],
  icon: 'queer_x_female_badge.svg'
)

Badge.create(
  name: 'Queer x Male Date',
  unlock_reqs: badge_unlock_reqs[11],
  icon: 'queer_x_male_badge.svg'
)

Badge.create(
  name: 'Queer Date',
  unlock_reqs: badge_unlock_reqs[12],
  icon: 'queer_x_queer_badge.svg'
)

Badge.create(
  name: 'Straight Date',
  unlock_reqs: badge_unlock_reqs[13],
  icon: 'straight_badge.svg'
)

Badge.create(
  name: 'First Place',
  unlock_reqs: badge_unlock_reqs[14],
  icon: 'trophy_badge.svg'
)

puts 'created badges'
