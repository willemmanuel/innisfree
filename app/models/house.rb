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
	
	def self.to_csv
	  CSV.generate do |csv|
	    csv << column_names
	    all.each do |houses|
	      csv << houses.attributes.values_at(*column_names)
	    end
	  end
	end
end
