json.array!(@discussions) do |discussion|
  json.extract! discussion, :id, :name
  json.url discussion_url(discussion, format: :json)
end
