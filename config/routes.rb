Rails.application.routes.draw do

  resources :posts do
    resources :comments
  end
  
  resources :posts do 
    member do
      put "like", to: "posts#upvote"
      put "dislike", to: "posts#downvote"
    end
  end
  
  resources :anonymous_rooms, only: [:new, :create, :show, :index]
  
  resources :anonymous_rooms do
    member do
      put "like", to: "anonymous_rooms#upvote"
      put "dislike", to: "anonymous_rooms#downvote"
    end
  end
    
  mount ActionCable.server => '/cable'
  
  devise_for :users
  
  root 'anonymous_rooms#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
