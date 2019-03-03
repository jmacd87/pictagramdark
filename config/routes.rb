Rails.application.routes.draw do
	root 'home#index'

	resources :users
	resources :posts
	resources :sessions, only: [:new, :create, :destroy]


  get "signup" => "users#new", as: "signup"
  get "login" => "sessions#new", as: "login"
  get "logout" => "sessions#destroy", as: "logout"
  

end
