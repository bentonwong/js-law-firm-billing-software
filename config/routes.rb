Rails.application.routes.draw do
  resources :lawyers, only: [:index, :new, :create, :edit, :update, :show]
  resources :clients, only: [:index, :new, :create, :edit, :update, :show]
  resources :matters, only: [:index, :new, :create, :edit, :update, :show]
  resources :time_entries, only: [:index, :new, :create, :edit, :update, :show]

  get "clients/:id/invoice" => "clients#invoice", as: :client_invoice

  root 'lawyers#index'

end
