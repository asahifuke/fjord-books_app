Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i(index show) do
    resources :user_follows, only: [:create, :destroy]
    get 'followings' => 'user_follows#followings'
    get 'followers' => 'user_follows#followers'
  end
end
