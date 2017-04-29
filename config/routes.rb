Rails.application.routes.draw do
  get 'case/new'

  get 'case/create'

  get 'case/edit'

  get 'case/update'

  get 'case/show'

  get 'case/destroy'

  get 'time_entry/new'

  get 'time_entry/create'

  get 'time_entry/edit'

  get 'time_entry/update'

  get 'time_entry/show'

  get 'time_entry/destroy'

  get 'client/new'

  get 'client/create'

  get 'client/edit'

  get 'client/update'

  get 'client/show'

  get 'client/destroy'

  get 'lawyer/new'

  get 'lawyer/create'

  get 'lawyer/edit'

  get 'lawyer/update'

  get 'lawyer/show'

  get 'lawyer/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
