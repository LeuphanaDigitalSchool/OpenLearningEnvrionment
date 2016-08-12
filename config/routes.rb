# frozen_string_literal: true
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1, except: [:new, :edit] do
      mount_devise_token_auth_for 'User', at: 'auth'
      get 'locales' => 'locales#index'

      resources :conversations, only: [:index, :show] do
        collection do
          post :sent
          post ':id/reply' => 'conversations#reply'
        end
      end

      namespace :admin do
        namespace :users do
          resources :public_users, :students, :supports, :teachers, :course_directors, :course_managers
          get 'profile_selects' => 'users#profile_selects'
        end
      end

      resources :courses
    end
  end
end
