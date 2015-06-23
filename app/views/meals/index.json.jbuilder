json.array!(@meals) do |meal|
  json.extract! meal, :id, :meal_date, :preordered_meals, :actual_meals, :extra_meals, :absence_with_notice
  json.url meal_url(meal, format: :json)
end
