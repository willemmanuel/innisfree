class ChangeAppointmetsTable < ActiveRecord::Migration
  def change
    change_table :appointments do |t|
      t.rename :physician_id, :doctor_id
    end
  end
end
