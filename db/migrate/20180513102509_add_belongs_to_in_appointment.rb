class AddBelongsToInAppointment < ActiveRecord::Migration[5.2]
  def change
    add_belongs_to :appointments, :dentist, index: true, foreign_key: true
    add_belongs_to :appointments, :patient, index: true, foreign_key: true
  end
end
