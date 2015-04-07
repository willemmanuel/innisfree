# == Schema Information
#
# Table name: appointments
#
#  id          :integer          not null, primary key
#  resident_id :integer
#  doctor_id   :integer
#  user_id     :integer
#  date        :date
#  time        :time
#  apt_type    :string(255)
#  notes       :text
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  test "csv generation" do
    @appointment = FactoryGirl.create(:appointment)
    generated_csv = Appointment.to_csv
    csv = CSV.parse(generated_csv)
    assert_equal(["id", "resident_id", "doctor_id", "user_id", "date", "time", "notes", "created_at", "updated_at", "apt_type", "cancel"], csv.first)
  end

end
