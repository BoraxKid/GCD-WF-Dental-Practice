class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :patients, :emai, :email
  end
end
