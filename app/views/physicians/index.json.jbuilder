json.array!(@physicians) do |physician|
  json.extract! physician, :id, :name, :address, :phone
  json.url physician_url(physician, format: :json)
end
