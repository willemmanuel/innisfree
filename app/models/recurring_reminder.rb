# == Schema Information
#
# Table name: recurring_reminders
#
#  id                :integer          not null, primary key
#  appointment_id    :integer
#  notification_date :date
#  created_at        :datetime
#  updated_at        :datetime
#

class RecurringReminder < ActiveRecord::Base
end
