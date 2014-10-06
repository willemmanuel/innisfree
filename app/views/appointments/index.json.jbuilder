json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :resident_id, :physician_id, :volunteer_id
  json.title appointment.resident.name + " - " + appointment.physician.name
  json.start DateTime.new(appointment.date.year, appointment.date.month, appointment.date.day, appointment.time.hour, appointment.time.min, appointment.time.sec, appointment.time.zone)
  json.url appointment_url(appointment)
end
