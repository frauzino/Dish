class Contact < MailForm::Base
  attribute :name, validate: true
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  attribute :nickname,  captcha: true
  def headers
    {
      #this is the subject for the email generated, it can be anything you want
      subject: "Email from Dish Contact Form",
      to: 'yourname@gmail.com', #put your email adrress here
      from: %("#{name}" <#{email}>)
      #the form will display the name entered by the user followed by the email
    }
  end
end
