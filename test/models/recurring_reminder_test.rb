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

require 'test_helper'

class RecurringReminderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
