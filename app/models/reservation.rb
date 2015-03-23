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

class Reservation < ActiveRecord::Base
	belongs_to :car
	belongs_to :user

	validates :start, presence: true
	validates :finish, presence: true
	validates :user_id, presence: true
	validates :car_id, presence: true
end
