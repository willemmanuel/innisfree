# == Schema Information
#
# Table name: apt_types
#
#  id         :integer          not null, primary key
#  apt_type   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class AptType < ActiveRecord::Base
end
