Rails.application.routes.draw do
  resources :skills
  resources :trainees

  get "/donut" => "dashboards#donut"
  get "/horizontal_bars" => "dashboards#horizontal_bars"
  get "/donut_with_data" => "dashboards#donut_with_data"
  get "/dashboard" => "dashboards#dashboard"
end
