Rails.application.routes.draw do
  get 'sessions/home'

  get 'sessions/create'

  get 'sessions/destroy'

  resources :lawyers, only: [:index, :new, :create, :edit, :update, :show]
  resources :clients, only: [:index, :new, :create, :edit, :update, :show]
  resources :matters, only: [:index, :new, :create, :edit, :update, :show]
  resources :time_entries, only: [:index, :new, :create, :edit, :update, :show]

  get "clients/:id/invoice" => "clients#invoice", as: :client_invoice
  get "matters/:id/time_entries/new" => "time_entries#new", as: :new_matter_time_entry

  root 'lawyers#index'

end
