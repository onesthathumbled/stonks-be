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

  #                   Admin Routes with Controllers
  
  # Create a new trader
  post '/admin/create_new_trader', to: 'users/users#create_new_trader'
  # Edit a specific trader
  patch '/admin/update_trader/:id', to: 'users/users#update_trader'
  # View a specific trader
  get '/admin/show_trader/:id', to: 'users/users#show_trader'
  # View all the traders that registered in the app
  get '/admin/show_traders', to: 'users/users#show_traders'
  # View all the pending traders
  get '/admin/show_pending_traders', to: 'users/users#show_pending_traders'
  # Approve a trader sign up
  patch '/admin/approve_trader/:id', to: 'users/users#approve_trader'
  # View all the transacions
  get '/admin/show_transactions', to: 'users/users#show_transactions'
  # Show specific admin
  get '/admin/show_admin/:id', to: 'users/users#show_admin'
  # Show all admins
  get '/admin/show_admins', to: 'users/users#show_admins'

  #                   Traders Routes with Controllers
  
  # Create an account
  post '/trader/register', to: 'users/users#register'
  # Login endpoint
  post '/trader/login', to: 'users/users#login'
  # Receive an email to confirm pending account
  # ------> will use Action Mailer here
  # Receive an email once an account has been approved
  # ------> will use Action Mailer here
  # Buy stocks
  post '/trader/buy', to: 'users/users#buy'
  # Sell stocks
  post '/trader/sell', to: 'users/users#sell'
  # Get portfolio
  get 'trader/portfolio', to: 'users/users#portfolio'
  # Get transactions of a specific trader
  get 'trader/transactions', to: 'users/users#transactions'
 
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
