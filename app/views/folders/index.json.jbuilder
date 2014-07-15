json.array!(@folders) do |folder|
  json.extract! folder, :id, :name, :mode, :trip_id, :total_cost, :description
  json.url folder_url(folder, format: :json)
end
