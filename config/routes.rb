Rails.application.routes.draw do
  get 'relationships/follow_user'
  get 'relationships/unfollow_user'
	root 'sessions#new'
  get 'notifications', to: 'notifications#index'
  get 'notifications/:id/link_through', to: 'notifications#link_through',
                                        as: :link_through
  get 'profiles/show'
  post ':user_name/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':user_name/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user
	get 'browse', to: 'posts#browse', as: :browse_posts
  resources :users
	
	resources :posts do
		resources :comments
    member do
      get 'like'
      get 'unlike'
    end
	end

	resources :sessions, only: [:new, :create, :destroy]

  get "signup" => "users#new", as: "signup"
  get "login" => "sessions#new", as: "login"
  get "logout" => "sessions#destroy", as: "logout"
  get "search" => "users#search", as: "search_page"
  get ':user_name', to: 'profiles#show', as: :profile
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
  patch ':user_name/edit', to: 'profiles#update', as: :update_profile

  
end
