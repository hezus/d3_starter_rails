json.array!(@trainees) do |trainee|
  json.extract! trainee, :id, :name, :gender, :age, :distance, :job_category
  json.url trainee_url(trainee, format: :json)
end
