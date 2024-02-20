# frozen_string_literal: true

mount Debugbar::Engine => Debugbar.config.prefix if defined? Debugbar

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  root to: 'root#index'

  match '/server', via: :all, controller: :server, action: :all

  match '/status/:status_code', via: :all, controller: :status, action: :all,
                                constraints: { status_code: /[0-9]{3}/ }

  get '/auth/login', action: :login, controller: 'auth'
end
