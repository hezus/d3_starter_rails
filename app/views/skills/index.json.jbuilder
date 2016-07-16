json.array!(@skills) do |skill|
  json.extract! skill, :id, :description, :category
  json.url skill_url(skill, format: :json)
end
