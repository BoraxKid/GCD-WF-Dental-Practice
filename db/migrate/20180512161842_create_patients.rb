class CreatePatients < ActiveRecord::Migration[5.2]

  def change
    create_table :patients do |t|
      t.string :name
      t.string :emai
      t.string :phone_number
      t.string :allergies
      t.string :medical_notes
      t.timestamps
    end
  end
end
