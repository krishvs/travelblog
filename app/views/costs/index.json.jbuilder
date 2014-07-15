json.array!(@costs) do |cost|
  json.extract! cost, :id, :item, :price, :count, :folder_id, :mode, :description, :date
  json.url cost_url(cost, format: :json)
end
