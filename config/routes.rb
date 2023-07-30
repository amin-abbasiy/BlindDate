# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'api/v1/groups#index'
  namespace :api do
    namespace :v1 do
      resources :groups, only: %i[index create] do
        get 'week/:week', on: :collection, action: :week
      end
      resources :invitations, only: %i[update]
    end
  end
end
