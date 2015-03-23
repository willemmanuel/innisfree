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

  has_paper_trail

  belongs_to :resident
  belongs_to :doctor
  belongs_to :user

  validates :doctor_id, presence: true
  validates :resident_id, presence: true
  validates :date, presence: true
  validates :time, presence: true

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |appointments|
	   csv << appointments.attributes.values_at(*column_names)
      end
    end
  end
end
