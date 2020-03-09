Rails.application.routes.draw do
  devise_for :users
  root 'staticpages#home'
  get  '/about',     to: 'staticpages#about'
end
