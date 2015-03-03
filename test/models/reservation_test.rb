# == Schema Information
#
# Table name: reservations
#
#  id         :integer          not null, primary key
#  start      :datetime
#  end        :datetime
#  user_id    :integer
#  car_id     :integer
#  created_at :datetime
#  updated_at :datetime
#  note       :text
#

require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
