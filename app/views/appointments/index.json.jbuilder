json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :resident_id, :physician_id, :volunteer_id, :date, :time, :for, :notes
  json.url appointment_url(appointment, format: :json)
end
