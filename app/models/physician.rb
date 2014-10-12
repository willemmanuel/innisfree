# == Schema Information
#
# Table name: physicians
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :string(255)
#  phone      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

include ActionView::Helpers::NumberHelper

class Physician < ActiveRecord::Base
	has_many :appointments, dependent: :destroy
end
