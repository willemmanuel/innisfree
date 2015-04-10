module CarsHelper
  #Determines if a car reservation's start and end time are acceptable
	def valid_times?(start, finish)
		if start > finish || start < Time.now
			return false
		else
			return true
		end
	end

  #Converts time into a readable formal
	def parse_time(date, time)
		fix_dst(Time.zone.parse("#{date} #{time.values.join(":")}#{Time.zone.formatted_offset.to_s.tr(':','')}"))
	end

  #Determines daylight savings time
	def fix_dst(time) 
		if time.dst?
			return time - 1.hour
		else
			return time
		end
	end

  #Determines if car reservations overlap each other
	def overlap?(existing_reservation, start, finish) 
		return (start <= existing_reservation.start && finish > existing_reservation.start) || (existing_reservation.start <= start && existing_reservation.finish > start) || (existing_reservation.start == start && existing_reservation.finish == finish)
	end

  #Determines if a car is available during a reservation time
	def car_available?(car, start, finish)
		car.reservations.each do |reservation|
			if overlap?(reservation, start, finish)
				return false
			end
		end
		return true
	end
end
