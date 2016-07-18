Rails.application.routes.draw do
  resources :skills
  resources :trainees

  get "/donut" => "dashboards#donut"
  get "/treemap" => "dashboards#treemap"
end
