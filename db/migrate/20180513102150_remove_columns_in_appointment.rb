class RemoveColumnsInAppointment < ActiveRecord::Migration[5.2]
  def change
    remove_column :appointments, :dentist
    remove_column :appointments, :patient
  end
end
