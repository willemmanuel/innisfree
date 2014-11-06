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

class Volunteer < ActiveRecord::Base
  belongs_to :house
  has_many :cars
  has_one :user
end
