json.array!(@bios) do |bio|
  json.extract! bio, :id
  json.url bio_url(bio, format: :json)
end
