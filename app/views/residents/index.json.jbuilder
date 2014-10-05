json.array!(@residents) do |resident|
  json.extract! resident, :id, :name, :house_id, :notes
  json.url resident_url(resident, format: :json)
end
