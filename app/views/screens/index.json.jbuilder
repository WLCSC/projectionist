json.array!(@screens) do |screen|
  json.extract! screen, :id, :name, :address
  json.url screen_url(screen, format: :json, protocol: 'https')
end
