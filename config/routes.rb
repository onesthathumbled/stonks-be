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

  # Admin Controllers
  post '/admin/create_new_trader', to: 'admins/admins#create_new_trader'
  patch '/admin/edit_trader/:id', to: 'admins/admins#edit_trader'
  get '/admin/show_trader', to: 'admins/admins#show_trader'
  

 
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
end
