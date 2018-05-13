class Admin::AppointmentsController < Comfy::Admin::BaseController

  before_action :build_appointment,  only: [:new, :create]
  before_action :load_appointment,   only: [:show, :edit, :update, :destroy]

  def index
    @appointments = Appointment.page(params[:page])
    respond_to do |format|
      format.html
      format.json { render json: AppointmentDatatable.new(view_context) }
    end
  end

  def show
    @dentists = Dentist.all;
    @patients = Patient.all;
    render
  end

  def new
    @dentists = Dentist.all;
    @patients = Patient.all;
    render
  end

  def edit
    @dentists = Dentist.all;
    @patients = Patient.all;
    render
  end

  def create
    @appointment.save!
    flash[:success] = 'Appointment created'
    redirect_to action: :edit, id: @appointment
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = 'Failed to create Appointment'
    render action: :new
  end

  def update
    @appointment.update_attributes!(appointment_params)
    flash[:success] = 'Appointment updated'
    redirect_to action: :edit, id: @appointment
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = 'Failed to update Appointment'
    render action: :edit
  end

  def destroy
    @appointment.destroy
    flash[:success] = 'Appointment deleted'
    redirect_to action: :index
  end

protected

  def build_appointment
    @appointment = Appointment.new(appointment_params)
  end

  def load_appointment
    @appointment = Appointment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Appointment not found'
    redirect_to action: :index
  end

  def appointment_params
    params.fetch(:appointment, {}).permit(:date, :dentist_id, :patient_id, :duration, :fee_paid, :notes)
  end
end
