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

  #Each house contains multiple users (the volunteers) and multiple residents (the coworkers)
	has_many :users
	has_many :residents

  #Ensures that houses have names when they are created
  validates :name, presence: true

  #Defines what a CSV list of the houses will look like
	def self.to_csv
	  CSV.generate do |csv|
	    csv << column_names
	    all.each do |houses|
	      csv << houses.attributes.values_at(*column_names)
	    end
	  end
	end
end
