class FixDoctorTypeColumn < ActiveRecord::Migration
  def change
  	rename_column :doctors, :type, :doctor_type
  end
end
