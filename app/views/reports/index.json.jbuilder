json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :resident_id, :doctor_id, :user_id
  json.title appointment.resident.name + " - " + appointment.doctor.name
  json.start DateTime.new(appointment.date.year, appointment.date.month, appointment.date.day, appointment.time.hour, appointment.time.min, appointment.time.sec, appointment.time.zone)
  json.url appointment_url(appointment)
end
