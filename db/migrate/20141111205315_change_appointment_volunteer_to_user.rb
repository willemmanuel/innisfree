class ChangeAppointmentVolunteerToUser < ActiveRecord::Migration
  def change
  	rename_column :appointments, :volunteer_id, :user_id
  end
end
