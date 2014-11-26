json.array!(@doctors) do |doctor|
  json.extract! doctor, :id, :name, :address, :phone
  json.url doctor_url(doctor, format: :json)
end
