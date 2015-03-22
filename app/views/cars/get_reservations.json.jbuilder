json.array!(@reservations) do |reservation|
  json.start reservation.start
  json.end reservation.finish
  json.title reservation.car.name + ' reserved by ' + reservation.user.name
  json.url url_for show_reservation_path(reservation)
  json.allDay false
end
