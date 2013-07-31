json.array!(@screens) do |screen|
  json.extract! screen, :name, :description
  json.url screen_url(screen, format: :json)
end
