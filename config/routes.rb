Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'
  devise_for :traders

  devise_for :admins, path: '', path_names: {
    sign_in: 'admin/login',
    sign_out: 'admin/logout',
    registration: 'admin/register'
  },
  controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }
  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # < -------------------------------------------------------------------------------------------- >
  # For Testing Purposes
  # devise_for :users

  devise_for :users, path: '', path_names: {
    sign_in: 'user/login',
    sign_out: 'user/logout',
    registration: 'user/register'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
