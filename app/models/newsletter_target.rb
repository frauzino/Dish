class NewsletterTarget < ApplicationRecord
  validates :email, presence: { message: 'Email can\'t be blank' },
                    uniqueness: { message: 'Email has already been taken' },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Email is not formatted correctly. (example@dish.io)' }
end
