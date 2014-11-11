# == Schema Information
#
# Table name: cars
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  user_id    :integer
#  for        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class CarTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
