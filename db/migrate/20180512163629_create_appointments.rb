class CreateAppointments < ActiveRecord::Migration[5.2]

  def change
    create_table :appointments do |t|
      t.datetime :date
      t.integer :dentist
      t.integer :patient
      t.integer :duration
      t.boolean :fee_paid
      t.string :notes
      t.timestamps
    end
  end
end
