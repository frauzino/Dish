class ContactController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request

    if @contact.deliver
      render turbo_stream: turbo_stream.replace('contact-form', partial: 'contact/contact_thank_you')
    else
      render turbo_stream: turbo_stream.replace('contact-form', partial: 'contact/contact_form')
    end
  end
end
