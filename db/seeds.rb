require 'faker'

User.destroy_all
Question.destroy_all

User.create(
  email: "a@a.a",
  password: "123456",
  first_name: "Richard",
  last_name: "Smith",
  is_admin: true,
  gender: "male"
)

10.times do Question.create(
  body: Faker::Quotes::Shakespeare.romeo_and_juliet_quote
)
end
