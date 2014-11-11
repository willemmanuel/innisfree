json.array!(@cars) do |car|
  json.extract! car, :id, :name, :user_id, :for
  json.url car_url(car, format: :json)
end
