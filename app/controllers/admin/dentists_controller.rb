class Admin::DentistsController < Comfy::Admin::BaseController

  before_action :build_dentist,  only: [:new, :create]
  before_action :load_dentist,   only: [:show, :edit, :update, :destroy]

  def index
    @dentists = Dentist.page(params[:page])
  end

  def show
    render
  end

  def new
    render
  end

  def edit
    render
  end

  def create
    @dentist.save!
    flash[:success] = 'Dentist created'
    redirect_to action: :edit, id: @dentist
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = 'Failed to create Dentist'
    render action: :new
  end

  def update
    @dentist.update_attributes!(dentist_params)
    flash[:success] = 'Dentist updated'
    redirect_to action: :edit, id: @dentist
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = 'Failed to update Dentist'
    render action: :edit
  end

  def destroy
    @dentist.destroy
    flash[:success] = 'Dentist deleted'
    redirect_to action: :index
  end

protected

  def build_dentist
    @dentist = Dentist.new(dentist_params)
  end

  def load_dentist
    @dentist = Dentist.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Dentist not found'
    redirect_to action: :index
  end

  def dentist_params
    params.fetch(:dentist, {}).permit(:name, :email, :phone_number, :dental_number, :is_active)
  end
end
