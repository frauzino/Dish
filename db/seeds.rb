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
  username: 'Test User',
  password: '123456',
  first_name: 'Richard',
  last_name: 'Smith',
  is_admin: true,
  gender: 'male',
  points: 50
)
User.create(
  email: 'b@b.b',
  username: 'Another Test',
  password: '123456',
  first_name: 'Bob',
  last_name: 'jones',
  is_admin: false,
  gender: 'male',
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
