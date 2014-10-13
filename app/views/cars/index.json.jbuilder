json.array!(@cars) do |car|
  json.extract! car, :id, :name, :volunteer_id, :for
  json.url car_url(car, format: :json)
end
