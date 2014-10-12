# == Schema Information
#
# Table name: appointments
#
#  id           :integer          not null, primary key
#  resident_id  :integer
#  physician_id :integer
#  volunteer_id :integer
#  date         :date
#  time         :time
#  for          :string(255)
#  notes        :text
#  created_at   :datetime
#  updated_at   :datetime
#

require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
