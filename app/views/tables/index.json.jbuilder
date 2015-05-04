json.array!(@tables) do |table|
  json.extract! table, :id, :seats, :shift_id, :available_seats
  json.url table_url(table, format: :json)
end
