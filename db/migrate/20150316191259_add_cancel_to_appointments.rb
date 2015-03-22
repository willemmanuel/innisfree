class AddCancelToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :cancel, :boolean
  end
end
