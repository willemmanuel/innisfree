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
  belongs_to :house
  
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |residents|
	csv << residents.attributes.values_at(*column_names)
      end
    end
  end

  def name 
  	super || "No name"
  end
  
end
