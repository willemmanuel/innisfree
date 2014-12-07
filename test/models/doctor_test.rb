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
  # test "the truth" do
  #   assert true
  # end
end
