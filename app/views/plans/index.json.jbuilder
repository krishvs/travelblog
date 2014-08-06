json.array!(@plans) do |plan|
  json.extract! plan, :id, :date_time, :name, :itenary_id, :short_description
  json.url plan_url(plan, format: :json)
end
