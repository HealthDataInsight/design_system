Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'pages#index'
  post 'form-handler', to: 'pages#form_handler'

  resources :styles, only: %i[index show], param: :style,
                     constraints: { style: /[a-z0-9_-]+/ }
  resources :components, only: %i[index show], param: :component,
                         constraints: { component: /[a-z0-9_-]+/ }

  resources :assistants
end
