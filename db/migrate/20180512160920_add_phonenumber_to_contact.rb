class AddPhonenumberToContact < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :phone_number, :string
  end
end
