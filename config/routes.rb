Rails.application.routes.draw do
  get '/search' => 'weather#search'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "weather#index"
end
