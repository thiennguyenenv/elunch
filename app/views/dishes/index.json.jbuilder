json.array!(@dishes) do |dish|
  json.extract! dish, :id, :name, :description, :rating, :category_id
  json.url dish_url(dish, format: :json)
end
