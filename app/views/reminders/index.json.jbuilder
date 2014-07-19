json.array!(@reminders) do |reminder|
  json.extract! reminder, :id, :name, :mode, :description, :sent
  json.url reminder_url(reminder, format: :json)
end
