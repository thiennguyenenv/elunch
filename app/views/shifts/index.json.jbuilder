json.array!(@shifts) do |shift|
  json.extract! shift, :id, :name, :description, :start_time, :end_time
  json.url shift_url(shift, format: :json)
end
