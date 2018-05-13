class Admin::PatientsController < Comfy::Admin::BaseController

  before_action :build_patient,  only: [:new, :create]
  before_action :load_patient,   only: [:show, :edit, :update, :destroy]

  def index
    @patients = Patient.page(params[:page])
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
    @patient.save!
    flash[:success] = 'Patient created'
    redirect_to action: :edit, id: @patient
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = 'Failed to create Patient'
    render action: :new
  end

  def update
    @patient.update_attributes!(patient_params)
    flash[:success] = 'Patient updated'
    redirect_to action: :edit, id: @patient
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = 'Failed to update Patient'
    render action: :edit
  end

  def destroy
    @patient.destroy
    flash[:success] = 'Patient deleted'
    redirect_to action: :index
  end

protected

  def build_patient
    @patient = Patient.new(patient_params)
  end

  def load_patient
    @patient = Patient.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Patient not found'
    redirect_to action: :index
  end

  def patient_params
    params.fetch(:patient, {}).permit(:name, :email, :phone_number, :allergies, :medical_notes)
  end
end
