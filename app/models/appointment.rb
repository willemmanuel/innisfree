class Appointment < ActiveRecord::Base
  belongs_to :resident
  belongs_to :physician
  belongs_to :volunteer
end
