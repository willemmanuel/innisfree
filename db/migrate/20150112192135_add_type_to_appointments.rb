class AddTypeToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :type, :string
    remove_column :appointments, :for, :string
  end
end
