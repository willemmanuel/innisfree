class AddAptTypeToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :apt_type, :string
    remove_column :appointments, :type, :string
  end
end
