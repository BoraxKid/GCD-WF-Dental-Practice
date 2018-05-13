class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:info] = "Message sent."
      redirect_to comfy_cms_render_page_path
    else
      render 'new'
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :phone_number, :message)
    end
end