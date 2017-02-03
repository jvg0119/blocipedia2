Rails.application.routes.draw do
	
	resources :charges, only: [:create, :new]
  post 'charges/downgrade' => 'charges#downgrade'

  resources :wikis
  
  devise_for :users
  resources :users, only: [:edit, :update, :show]

  get 'index' => 'welcome#index'
  get 'about' => 'welcome#about'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
