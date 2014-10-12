# == Schema Information
#
# Table name: residents
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  house_id   :integer
#  notes      :text
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class ResidentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
