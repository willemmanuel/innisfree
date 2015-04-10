module ApplicationHelper
  #Helps with getting Google map for doctors to be displayed on appointments
	def map_link(address)
		"https://www.google.com/maps/preview?q="+address
	end
end
