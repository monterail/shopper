Rails.application.routes.draw do
  root to: "products#index"

  devise_for :users

  resources :products do
    resources :orders, only: [:new, :create]
  end
  resources :orders, only: [:show, :index]
  resources :special_offers
  resources :users

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
