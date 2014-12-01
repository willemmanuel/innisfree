json.array!(@appointments_counts) do |appointment|
  if appointment[1] == 1
    json.title appointment[1].to_s + " appointment"
  else
    json.title appointment[1].to_s + " appointments"
  end
  json.start DateTime.new(appointment[0].year, appointment[0].month, appointment[0].day)
  json.allDay true
end
