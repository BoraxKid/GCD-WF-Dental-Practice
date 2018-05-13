class AppointmentDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :edit_admin_appointment_path, :admin_appointment_path

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      date: { source: "Appointment.date" },
      dentist_id: { source: "Dentist.name" },
      patient_id: { source: "Patient.name" },
      duration: { source: "Appointment.duration" },
      fee_paid: { source: "Appointment.fee_paid" },
      actions: { source: "actions", searchable: false, orderable: false },
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
        actions: link_to('Edit', edit_admin_appointment_path(record), class: 'btn btn-outline-secondary') + link_to('Delete', admin_appointment_path(record), method: :delete, data: {confirm: 'Are you sure?'}, class: 'btn btn-danger'),
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
