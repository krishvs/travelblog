json.array!(@itenaries) do |itenary|
  json.extract! itenary, :id, :name, :user_id, :folder_id
  json.url itenary_url(itenary, format: :json)
end
