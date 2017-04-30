Rails.application.routes.draw do

  resources :lawyers, only: [:index, :new, :create, :edit, :update, :show]
  resources :clients, only: [:index, :new, :create, :edit, :update, :show]
  resources :cases, only: [:index, :new, :create, :edit, :update, :show]
  resources :time_entries, only: [:index, :new, :create, :edit, :update, :show]

  root 'lawyers#index'

end
