# == Schema Information
#
# Table name: houses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  phone      :string(255)
#

require 'test_helper'

class HouseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "csv generation" do
    @house = FactoryGirl.create(:house)
    generated_csv = House.to_csv
    csv = CSV.parse(generated_csv)
    assert_equal(["id", "name", "created_at", "updated_at", "phone"], csv.first)
  end
end
