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

class Resident < ActiveRecord::Base
  belongs_to :house, dependent: :destroy
end
