Rails.application.routes.draw do
  devise_for :users
  get 'home/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#top'
  resources :posts
  resources :users
  resources :searches, only: [:index]
  resources :posts, only: [:new, :create, :index, :show] do
  	resource :favorites, only: [:create, :destroy]
  	resources :post_comments, only: [:create, :destroy]

  	get "search" => "users#search"
  	# get "search" => "posts#search"

  	resources :tags
  		get 'posts', to: 'posts#search'
  end
  	resources :users do
  		resource :unsubscribe, only: [:edit, :destroy], module: :users
  	member do
	get "check"
	end
	end



end
