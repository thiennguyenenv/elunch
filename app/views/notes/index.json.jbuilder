json.array!(@notes) do |note|
  json.extract! note, :id, :name, :description, :group_id, :reset_option
  json.url note_url(note, format: :json)
end
