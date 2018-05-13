class AppointmentDatatable < AjaxDatatablesRails::Base

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      date: { source: "Appointment.date" },
      dentist_id: { source: "Dentist.name" },
      patient_id: { source: "Patient.name" },
      duration: { source: "Appointment.duration" },
      fee_paid: { source: "Appointment.fee_paid" },
      # id: { source: "User.id", cond: :eq },
      # name: { source: "User.name", cond: :like }
    }
  end

  def data
    records.map do |record|
      {
        date: record.date,
        dentist_id: record.dentist.name,
        patient_id: record.patient.name,
        duration: record.duration,
        fee_paid: record.fee_paid,
        DT_RowID: record.id,
        # example:
        # id: record.id,
        # name: record.name
      }
    end
  end

  def get_raw_records
    # Appointment.all
    Appointment.joins(:dentist, :patient)
  end

end
