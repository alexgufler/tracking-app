Rails.application.routes.draw do
  # resources :trackings
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/track", to: "trackings#track"
  
  # Defines the root path route ("/")
  # root "articles#index"
end
