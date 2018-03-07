class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      flash[:success] = "Thank you for your message! I'll get back to you shortly!"
      redirect_to new_contact_path
    else
      render "new"
    end
  end


  private
  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
