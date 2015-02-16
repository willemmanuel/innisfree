class CreateRecurringReminders < ActiveRecord::Migration
  def change
    create_table :recurring_reminders do |t|
      t.integer :appointment_id
      t.date :notification_date

      t.timestamps
    end
  end
end
