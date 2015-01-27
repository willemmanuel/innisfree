json.array!(@reservations) do |reservation|
  json.start reservation.start
  json.end reservation.end
  json.title reservation.car.name
  json.allDay false
end
