json.array!(@seating_chart_categories) do |category|
  json.extract! category, :id, :name, :description
  json.url seating_chart_category_url(category, format: :json)
end
