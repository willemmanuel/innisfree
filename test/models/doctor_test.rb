# == Schema Information
#
# Table name: doctors
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  address     :string(255)
#  phone       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  doctor_type :string(255)
#

require 'test_helper'

class DoctorTest < ActiveSupport::TestCase
  test "csv generation" do
    @doctor = FactoryGirl.create(:doctor)
    generated_csv = Doctor.to_csv
    csv = CSV.parse(generated_csv)
    assert_equal(["id", "name", "address", "phone", "created_at", "updated_at", "doctor_type"], csv.first)
  end
end
