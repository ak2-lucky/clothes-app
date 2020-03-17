Rails.application.routes.draw do
  devise_for :users
  root 'staticpages#home'
  get  '/about',     to: 'staticpages#about'
  resources :posts,          only: [:new, :index, :show, :create, :destroy]
  resources :users,          only: [:show]
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  
  
end
