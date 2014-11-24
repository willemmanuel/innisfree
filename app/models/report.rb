class Report < ActiveRecord::Base

  has_paper_trail

  belongs_to :appointment

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |appointments|
	csv << appointments.attributes.values_at(*column_names)
      end
    end
  end
end
