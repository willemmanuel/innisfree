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

class House < ActiveRecord::Base
	has_many :users
	has_many :residents

  validates :name, presence: true
	
	def self.to_csv
	  CSV.generate do |csv|
	    csv << column_names
	    all.each do |houses|
	      csv << houses.attributes.values_at(*column_names)
	    end
	  end
	end
end
