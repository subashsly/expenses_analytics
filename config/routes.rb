Rails.application.routes.draw do
  get 'expenses/index'

  get 'expenses/new'

  get 'expenses/new'

  get 'expense/index'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'account_activations/edit'

  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup' => 'members#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :members
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :incomes do 
    get "delete"
  end
  resources :expenses do 
    get "delete"
  end
  resources :reminders
end
