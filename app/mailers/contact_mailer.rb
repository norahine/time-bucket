class ContactMailer < ApplicationMailer
  default to: "Time Bucket <baranska.n@gmail.com>"

  def contact_email(contact)
    @name = contact.name
    @email = contact.email
    @message = contact.message

    mail(reply_to: @email, subject: "Contact Form Message from Time Bucket")
  end
end
