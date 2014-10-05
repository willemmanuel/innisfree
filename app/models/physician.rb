class Physician < ActiveRecord::Base
	has_many :appointments
end
