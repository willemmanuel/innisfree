# == Schema Information
#
# Table name: appointments
#
#  id          :integer          not null, primary key
#  resident_id :integer
#  doctor_id   :integer
#  user_id     :integer
#  date        :date
#  time        :time
#  notes       :text
#  created_at  :datetime
#  updated_at  :datetime
#  apt_type    :string(255)
#

class Appointment < ActiveRecord::Base

  has_paper_trail # allows changes to appointments to be tracked with the paper_trail gem

  # The following lines establish a one-to-one relationship between that data_type and appointments. This means that these fields are checked and the values input for the appointment must exist in that fields table of the database, ensuring that appoinments are not created for non-existant residents, doctors, or users.
  belongs_to :resident
  belongs_to :doctor
  belongs_to :user

  # Data validators to ensure that necessary fields are filled out when an appointment is created or updated
  validates :doctor_id, presence: true
  validates :resident_id, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :apt_type, presence: true

  # Allows all the appointments to be exported into a CSV file
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names # writes the database column names to the CSV file as headers
      all.each do |appointments| # writes each appointment to the CSV
	   csv << appointments.attributes.values_at(*column_names)
      end
    end
  end
end
