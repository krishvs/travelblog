json.array!(@maps) do |map|
  json.extract! map, :id, :name, :mode, :description, :transport
  json.url map_url(map, format: :json)
end
