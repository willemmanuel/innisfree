class TestController < ApplicationController
  def hello
  	@residents = Resident.all
  	@volunteers = Volunteer.all
 	@houses = House.all
 	@appointments = Appointment.all
  end
end
