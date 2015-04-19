class Report < ActiveRecord::Base

  has_paper_trail
  # a one-to-one relationship with appointment, valid appointments must exist in database
  belongs_to :appointment

  # defines the content for CSV list
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |appointments|
	csv << appointments.attributes.values_at(*column_names)
      end
    end
  end
end
