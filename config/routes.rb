Rails.application.routes.draw do
  resources :tasks



  resources :orders do
    get :sales, on: :collection
    resources :certificates
  end
  get 'orders/:id/approve', to: 'orders#approve'

  #patch 'orders/:id', to: 'orders#updatea'
  get 'sessions/new'
  get 'user/new'
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
end
