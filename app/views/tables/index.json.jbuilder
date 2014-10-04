json.array!(@tables) do |table|
  json.extract! table, :id, :topic, :date, :agenda, :volume
  json.url table_url(table, format: :json)
end
