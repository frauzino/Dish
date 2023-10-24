require 'faker'

puts 'cleaning database'

SurveyQuestion.destroy_all
Option.destroy_all

User.destroy_all
Question.destroy_all
Survey.destroy_all

puts 'Database clean'

puts 'Creating admin user'

User.create(
  email: 'a@a.a',
  password: '123456',
  first_name: 'Richard',
  last_name: 'Smith',
  is_admin: true,
  gender: 'male'
)

puts 'Admin ser email: a@a.a passcode: 123456 created'

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
