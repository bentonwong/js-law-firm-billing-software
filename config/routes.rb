Rails.application.routes.draw do

  resources :sessions, only: [:home, :new, :create, :destroy]
  resources :lawyers
  resources :clients, only: [:index, :new, :create, :edit, :update, :show]
  resources :matters, only: [:index, :new, :create, :edit, :update, :show]
  resources :time_entries, only: [:index, :new, :create, :edit, :update, :show]

  get "clients/:id/invoice" => "clients#invoice", as: :client_invoice
  get "matters/:id/time_entries/new" => "time_entries#new", as: :new_matter_time_entry
  get '/signin', to: 'sessions#new', as: 'signin'
  get '/signup', to: 'lawyers#new', as: 'signup'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#home'
  get '/sessions', to: 'sessions#home'

  root 'sessions#home'

end
