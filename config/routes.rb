Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  root "home#index"

  put "/article/:id/like", to: 'articles#like', as: 'like_article'
  put "/article/:id/dislike", to: 'articles#dislike', as: 'dislike_article'

  put "/comment/:id/like", to: 'comments#like', as: 'like_comment'
  put "/comment/:id/dislike", to: 'comments#dislike', as: 'dislike_comment'
  
  resources :articles do
    resources :comments
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
