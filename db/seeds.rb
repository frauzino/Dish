require 'faker'

puts 'cleaning database'

SurveyQuestion.destroy_all
UserBadge.destroy_all

Referral.destroy_all
Option.destroy_all
Result.destroy_all
Survey.destroy_all
User.destroy_all
Question.destroy_all
Badge.destroy_all
School.destroy_all

puts 'Database clean'
puts 'Creating Schools'

School.create(
  name: 'Concordia',
  points: 50
)

School.create(
  name: 'McGill',
  points: 50
)
School.create(
  name: 'Akron University',
  points: 50
)

puts 'Creating admin user'

User.create(
  email: 'a@a.a',
  username: 'Plantbaby',
  password: '123456',
  first_name: 'Richard',
  last_name: 'Smith',
  is_admin: true,
  gender: 'Male',
  school: School.first,
  points: 0,
  referral: Referral.new(code: SecureRandom.alphanumeric(8))
)
User.create(
  email: 'b@b.b',
  username: 'Corvette',
  password: '123456',
  first_name: 'Bob',
  last_name: 'jones',
  is_admin: false,
  gender: 'Female',
  school: School.last,
  points: 0,
  referral: Referral.new(code: SecureRandom.alphanumeric(8))
)

puts 'Admin created email: a@a.a passcode: 123456'
puts 'second test user created. email: b@b.b passcode 123456'

puts 'Creating questions'

# 10.times do
#   Question.create(
#     body: Faker::Quotes::Shakespeare.unique.romeo_and_juliet_quote
#   )
#   Option.create(
#     body: 'yes',
#     question: Question.last
#   )
#   Option.create(
#     body: 'no',
#     question: Question.last
#   )
# end

Question.create(
  body: 'Do you identify as',
  options: [
    Option.create(body: 'Male', value: 1),
    Option.create(body: 'Female', value: 1),
    Option.create(body: 'Nonbinary', value: 1),
    Option.create(body: 'Other', value: 1)
  ]
)
Question.create(
  body: 'Was the person you went on a date with...',
  options: [
    Option.create(body: 'Male', value: 1),
    Option.create(body: 'Female', value: 1),
    Option.create(body: 'Nonbinary', value: 1),
    Option.create(body: 'Other', value: 1)
  ]
)
Question.create(
  body: 'Did the person you went on a date with do anything to make you feel uncomfortable?',
  options: [
    Option.create(body: 'Gave you lusty looks', value: 3),
    Option.create(body: 'Too handsy', value: 1),
    Option.create(body: 'Looking at others while on the date with you', value: 5),
    Option.create(body: 'Other', value: 3),
    Option.create(body: 'None of the above', value: 10)
  ]
)
Question.create(
  body: 'On your date, did you notice any immediate/obvious red flags?',
  options: [
    Option.create(body: 'Arrived late', value: 4),
    Option.create(body: 'Use of misogynistic/misandric language; ie. made sexually excplicit comments about your appearance', value: 1),
    Option.create(body: 'Unable to contribute financially; ie. credit card declined', value: 3),
    Option.create(body: 'use of vulgar or demeaning language', value: 1),
    Option.create(body: 'Tried to get you to stay out on the date longer than you wanted', value: 2),
    Option.create(body: 'other', value: 2),
    Option.create(body: 'None of the above', value: 10)
  ]
)
Question.create(
  body: 'Was the person you went on a date with funny/had a good sense of humour, or were they more intense and serious?',
  options: [
    Option.create(body: 'Funny and had a good sense of humour', value: 9),
    Option.create(body: 'intense and serious', value: 7)
  ]
)
Question.create(
  body: 'How would you describe their demeaner/personality type?',
  options: [
    Option.create(body: 'Cocky - Bragged about job/money/possessions', value: 5),
    Option.create(body: 'Confident - Open and honest, but without all the bravado', value: 10),
    Option.create(body: 'Insecure - Appeared insecure and unsure', value: 3)
  ]
)
Question.create(
  body: 'If your date was male, was he chivalrous? (For example; open doors, pull our chair, let you order first)',
  options: [
    Option.create(body: 'Yes', value: 8),
    Option.create(body: 'No', value: 2),
    Option.create(body: 'N/A', value: 5)
  ]
)
Question.create(
  body: 'Were they rude to the waitstaff/people who served or catered to you on your date?',
  options: [
    Option.create(body: 'Yes', value: 1),
    Option.create(body: 'No', value: 10)
  ]
)
Question.create(
  body: 'Did they drink excessively on the date, to the point of becoming buzzed or intoxicated?',
  options: [
    Option.create(body: 'Yes', value: 3),
    Option.create(body: 'No', value: 8)
  ]
)
Question.create(
  body: 'Did they respect your opinions, even if they differed from their own?',
  options: [
    Option.create(body: 'Yes', value: 9),
    Option.create(body: 'No', value: 2)
  ]
)
Question.create(
  body: 'Did they avoid hot-button topics like religion, abortion and politics?',
  options: [
    Option.create(body: 'Yes', value: 4),
    Option.create(body: 'No', value: 6)
  ]
)
Question.create(
  body: 'Did they dominate the conversation?',
  options: [
    Option.create(body: 'Yes', value: 4),
    Option.create(body: 'No', value: 6)
  ]
)
Question.create(
  body: 'Did they appear to be genuinely happy and content with their life?',
  options: [
    Option.create(body: 'Yes', value: 8),
    Option.create(body: 'No', value: 3)
  ]
)
Question.create(
  body: 'Did they seem honest and trustworthy?',
  options: [
    Option.create(body: 'Yes', value: 9),
    Option.create(body: 'No', value: 1)
  ]
)
Question.create(
  body: 'Did they seem needy or clingy?',
  options: [
    Option.create(body: 'Yes', value: 3),
    Option.create(body: 'No', value: 7)
  ]
)
Question.create(
  body: 'Did they seem entitled or arrogant?',
  options: [
    Option.create(body: 'Yes', value: 3),
    Option.create(body: 'No', value: 7)
  ]
)
Question.create(
  body: 'How attractive was your date?',
  options: [
    Option.create(body: 'Very attractive', value: 8),
    Option.create(body: 'Moderately attractive', value: 5),
    Option.create(body: 'Unattractive', value: 2)
  ]
)
Question.create(
  body: 'When you met in person did their dating profile picture match their actual physical appearance?',
  options: [
    Option.create(body: 'Yes', value: 8),
    Option.create(body: 'No', value: 2)
  ]
)
Question.create(
  body: 'How did they respond when the bill came/it was time to pay for something?',
  options: [
    Option.create(body: 'I paid', value: 3),
    Option.create(body: 'They paid', value: 7),
    Option.create(body: 'We split the cost', value: 8),
    Option.create(body: 'Not applicable/no bill or payment needed', value: 5)
  ]
)
Question.create(
  body: 'Did they brag about their job/career, what car they drive, where they live, or other trappings of success?',
  options: [
    Option.create(body: 'Yes', value: 3),
    Option.create(body: 'No', value: 7)
  ]
)
Question.create(
  body: 'Did they complain about spending money or discuss upcoming expenses?',
  options: [
    Option.create(body: 'Yes', value: 3),
    Option.create(body: 'No', value: 7)
  ]
)
Question.create(
  body: 'Did they seem financially stable enough to travel abroad if they desired?',
  options: [
    Option.create(body: 'Yes', value: 8),
    Option.create(body: 'No', value: 2)
  ]
)
Question.create(
  body: 'Do they have children?',
  options: [
    Option.create(body: 'Yes', value: 5),
    Option.create(body: 'No', value: 5)
  ]
)
Question.create(
  body: 'Did they communicate a desire to date exclusively?',
  options: [
    Option.create(body: 'Yes', value: 5),
    Option.create(body: 'No', value: 5)
  ]
)
Question.create(
  body: 'Do they read books, articles and/or follow the news?',
  options: [
    Option.create(body: 'Yes', value: 8),
    Option.create(body: 'No', value: 4)
  ]
)
Question.create(
  body: 'Did they speak positively about their family?',
  options: [
    Option.create(body: 'Yes', value: 8),
    Option.create(body: 'No', value: 4)
  ]
)
Question.create(
  body: 'How did you feel at the end of the date?',
  options: [
    Option.create(body: 'Positive - It seems like we will keep in touch / go out again', value: 8),
    Option.create(body: 'Negative - No positive outcome / doubtful for a future date', value: 2),
    Option.create(body: 'We hooked up', value: 8)
  ]
)


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
  icon: '1x_survey_badge.svg'
)

Badge.create(
  name: 'First Friend',
  unlock_reqs: badge_unlock_reqs[5],
  icon: '1x_friends_badge.svg'
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
