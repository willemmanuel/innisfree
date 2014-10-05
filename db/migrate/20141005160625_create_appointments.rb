class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.belongs_to :resident, index: true
      t.belongs_to :physician, index: true
      t.belongs_to :volunteer, index: true
      t.date :date
      t.time :time
      t.string :for
      t.text :notes

      t.timestamps
    end
  end
end
