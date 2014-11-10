# == Schema Information
#
# Table name: appointments
#
#  id           :integer          not null, primary key
#  resident_id  :integer
#  physician_id :integer
#  volunteer_id :integer
#  date         :date
#  time         :time
#  for          :string(255)
#  notes        :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Appointment < ActiveRecord::Base
  belongs_to :resident
  belongs_to :physician
  belongs_to :volunteer
  
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |appointments|
	csv << appointments.attributes.values_at(*column_names)
      end
    end
  end
end
