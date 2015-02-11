json.array!(@reservations) do |reservation|
  json.start reservation.start
  json.end reservation.end
  json.title reservation.car.name + ' reserved by ' + reservation.user.name
  json.allDay false
end
