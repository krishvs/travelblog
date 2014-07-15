json.array!(@photos) do |photo|
  json.extract! photo, :id, :name, :mode, :folder_id
  json.url photo_url(photo, format: :json)
end
