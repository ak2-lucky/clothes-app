Rails.application.routes.draw do
  root 'staticpages#home'
  get  '/about',     to: 'staticpages#about'
end
