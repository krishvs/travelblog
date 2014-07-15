json.array!(@descriptions) do |description|
  json.extract! description, :id, :folder_id, :description, :title, :mode
  json.url description_url(description, format: :json)
end
