Rails.application.routes.draw do
  get 'groups/new'
  get 'groups/show'
  get 'groups/edit'
  get 'groups/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'homes#top'
  get "home/about"=>"homes#about"
  get "search"=>"searches#search"

  resources :users, only: [:index,:show,:edit,:update] do
    member do
      get :followings, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :groups do
    resources :group_users, only: [:create,:destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
