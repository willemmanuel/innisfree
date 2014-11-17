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

class Car < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :user
end
