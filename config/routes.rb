Rails.application.routes.draw do
  root 'staticpages#home'
  get  '/about',             to: 'staticpages#about'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users,          only: [:show]
  resources :posts,          only: [:new, :index, :show, :create, :destroy] do
    resources :comments,     only: [:create, :destroy]
  end
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
