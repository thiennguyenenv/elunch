json.array!(@meal_logs) do |meal_log|
  json.extract! meal_log, :id, :meal_id, :table_id, :tracking_data
  json.url meal_log_url(meal_log, format: :json)
end
