Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'staticpages#home'
  get  '/about',             to: 'staticpages#about'
  resources :posts,          only: [:new, :index, :show, :create] do
    resources :comments,     only: [:create, :destroy]
  end
  resources :posts,          only: [:destroy]
  resources :users,          only: [:show]
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
