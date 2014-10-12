# == Schema Information
#
# Table name: volunteers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  phone      :string(255)
#  house_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class VolunteerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
