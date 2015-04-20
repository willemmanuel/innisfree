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

  # Establishes a one-to-many relationship between houses and residents. Each resident has a house where they reside.
  belongs_to :house

  # Validates that each resident has a name as a requirement for creating a resident object
  validates :name, presence: true

  # Specifies what the generated CSV list of residents will look like
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names # headers for the CSV report
      all.each do |residents| # for each resident, populate the fields specified in column_names
	csv << residents.attributes.values_at(*column_names)
      end
    end
  end

  def name 
  	super || "No Name"
  end
  
end
