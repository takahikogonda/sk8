Rails.application.routes.draw do
  devise_for :users
  get 'home/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#top'
  resources :posts
  resources :users
  resources :posts, only: [:new, :create, :index, :show] do
  	resource :favorites, only: [:create, :destroy]
  	resources :post_comments, only: [:create, :destroy]

  	get "search" => "uses#search"
  	get "search" => "posts#search"
  end

end
