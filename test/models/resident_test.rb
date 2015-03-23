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
  
  test "test empty csv output" do
	csv = Resident.to_csv
	assert csv[0..1] == "id"
  end
  
  test "test csv for escaped output" do
    FactoryGirl.create(:resident, house_id: 2, id: 3, name: "John, Smith")
    csv = Resident.to_csv
	assert csv.partition('id,name,house_id,notes,created_at,updated_at').last[1..17].eql? '3,"John, Smith",2'
	assert csv[0..1] == "id"
  end
  
end
