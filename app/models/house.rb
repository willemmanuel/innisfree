# == Schema Information
#
# Table name: houses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class House < ActiveRecord::Base
	has_many :volunteers
	has_many :residents
end
