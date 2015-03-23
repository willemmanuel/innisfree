module CarsHelper
	def valid_times?(start, finish)
		if start > finish || start < Time.now
			return false
		else
			return true
		end
	end

	def parse_time(date, time)
		fix_dst(Time.zone.parse("#{date} #{time.values.join(":")}#{Time.zone.formatted_offset.to_s.tr(':','')}"))
	end

	def fix_dst(time) 
		if time.dst?
			return time - 1.hour
		else
			return time
		end
	end

	def overlap?(existing_reservation, start, finish) 
		return (start <= existing_reservation.start && finish > existing_reservation.start) || (existing_reservation.start <= start && existing_reservation.finish > start) || (existing_reservation.start == start && existing_reservation.finish == finish)
	end

	def car_available?(car, start, finish)
		car.reservations.each do |reservation|
			if overlap?(reservation, start, finish)
				return false
			end
		end
		return true
	end
end
