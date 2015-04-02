json.array!(@meals) do |meal|
  json.extract! meal, :id, :name, :description, :rating, :meal_type_id
  json.url meal_url(meal, format: :json)
end
