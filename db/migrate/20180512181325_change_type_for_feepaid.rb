class ChangeTypeForFeepaid < ActiveRecord::Migration[5.2]
  def change
    change_column(:appointments, :fee_paid, :float, using: '0')
  end
end
