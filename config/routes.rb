Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'staticpages#home'
  get  '/about',     to: 'staticpages#about'
  resources :posts,          only: [:new, :index, :show, :create, :destroy]
  
  
end
