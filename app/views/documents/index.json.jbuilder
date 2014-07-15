json.array!(@documents) do |document|
  json.extract! document, :id, :name, :mode, :folder_id, :description
  json.url document_url(document, format: :json)
end
