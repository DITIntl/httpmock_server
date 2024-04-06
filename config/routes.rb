# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  # mount Debugbar::Engine => Debugbar.config.prefix if defined? Debugbar
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  constraints subdomain: ['', 'www'] do
    get 'up' => 'rails/health#show', as: :rails_health_check

    root to: 'root#index'

    match '/server', via: :all, controller: :server, action: :all

    match '/status/:status_code', via: :all, controller: :status, action: :all, constraints: { status_code: /[0-9]{3}/ }

    get '/auth/login', action: :login, controller: 'auth'
    get '/auth/sign-up', action: :sign_up, controller: 'auth'
    post '/auth/login', action: :post_login, controller: 'auth'
    post '/auth/sign-up', action: :post_sign_up, controller: 'auth'
    delete '/auth/logout', action: :delete_logout, controller: 'auth'

    put '/account', action: :update, controller: 'users'
    get '/account', action: :edit, controller: 'users'
    delete '/account', action: :destroy, controller: 'users'

    resources :active_sessions, only: [:destroy] do
      collection do
        delete 'destroy_all'
      end
    end

    resources :confirmations, only: %i[create edit new], param: :confirmation_token
    resources :passwords, only: %i[create edit new update], param: :password_reset_token

    get '/projects/new', action: :new, controller: 'projects', as: 'new_project'
    get '/projects', action: :index, controller: 'projects', as: 'index_project'
    get '/projects/:id', action: :show, controller: 'projects', as: 'show_project'
    get '/projects/:id/edit', action: :edit, controller: 'projects', as: 'edit_project'
    delete '/projects/:id', action: :delete, controller: 'projects', as: 'delete_project'
    post '/projects', action: :create, controller: 'projects', as: 'create_project'
    patch '/projects/:id', action: :update, controller: 'projects', as: 'update_project'

    get '/projects/:project_id/endpoints/new', action: :new, controller: :endpoints, as: 'new_endpoint'
    get '/projects/:project_id/endpoints/:id/edit', action: :edit, controller: :endpoints, as: 'edit_endpoint'
    get '/projects/:project_id/endpoints/:id', action: :show, controller: :endpoints, as: 'show_endpoint'
    patch '/projects/:project_id/endpoints/:id/edit', action: :update, controller: :endpoints, as: 'update_endpoint'
    delete '/projects/:project_id/endpoints/:id', action: :delete, controller: :endpoints, as: 'delete_endpoint'
    post '/projects/:project_id/endpoints', action: :create, controller: :endpoints, as: 'create_endpoint'
  end

  match '*all', via: :all, controller: :requests, action: :all
end
# rubocop:enable Metrics/BlockLength
