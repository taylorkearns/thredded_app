Thredded::Application.routes.draw do
  mount Thredded::Engine => '/forum'

  devise_for :users, controllers: {
    registrations: 'registrations',
    sessions: 'sessions'
  }
  resources :users

  devise_scope :user do
    post '/auth/:provider/callback', to: 'sessions#create'
    get '/auth/:provider/callback', to: 'sessions#create'
  end

  get '/auth/failure', to: redirect('/')
  get '/auth/github', as: :auth_github
  put '/identities' => 'identities#update', as: :identity

  resources :preferences

  get '/login' => redirect('/users/sign_in')
  get '/log_in' => redirect('/users/sign_in')
  get '/sign_in' => redirect('/users/sign_in')
  get '/logout' => redirect('/users/sign_out')
  get '/log_out' => redirect('/users/sign_out')
  get '/forgot_password' => redirect('/users/password/new')
  get '/user/forgot_password' => redirect('/users/password/new')
  get '/user/forgot_username' => redirect('/users/password/new')

  root to: 'thredded/messageboards#index'
end
