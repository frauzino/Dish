class Contact < MailForm::Base
  attribute :name, validate: { presence: true }
  attribute :email, validate: URI::MailTo::EMAIL_REGEXP
  attribute :message, validate: { presence: true }
  attribute :nickname, captcha: true
  def headers
    {
      # this is the subject for the email generated, it can be anything you want
      subject: 'Email from Dish Contact Form',
      to: 'contact@letsdish.io', # put your email adrress here
      from: %("#{name}" <#{email}>)
      # the form will display the name entered by the user followed by the email
    }
  end
end
