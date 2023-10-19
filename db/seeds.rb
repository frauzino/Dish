require 'faker'

10.times do Question.create(
  body: Faker::Quotes::Shakespeare.romeo_and_juliet_quote
)
end
