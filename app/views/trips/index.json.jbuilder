json.array!(@trips) do |trip|
  json.extract! trip, :id, :name, :user_id, :mode, :description
  json.url trip_url(trip, format: :json)
end
