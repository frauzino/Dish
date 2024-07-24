class Contact < MailForm::Base
  attribute :name, validate: { presence: true }
  attribute :email, validate: URI::MailTo::EMAIL_REGEXP
  attribute :message, validate: { presence: true }
  attribute :nickname, captcha: true
  def headers
    {
      # this is the subject for the email generated, it can be anything you want
      subject: "Email from Dish Contact Form. from: #{name}",
      to: 'contact@letsdish.io', # target email adrress
      reply_to: %("#{name}" <#{email}>),
      from: 'no-reply@letsdish.io' # this is the email address the generated email will be sent from, verified through SendGrid
      # the form will display the name entered by the user followed by the email
    }
  end
end
