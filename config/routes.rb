# frozen_string_literal: true
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1, except: [:new, :edit] do
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:invitations, :passwords]
      devise_for :users, path: 'auth', only: [:invitations, :passwords],
                         controllers: { invitations: 'api/v1/overrides/invitations',
                                        passwords: 'api/v1/overrides/passwords' }
      get 'profile/:id' => 'users#show'
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
          resources :users, only: [:destroy]
          get '/' => 'users#index'
          get 'profile_selects' => 'users#profile_selects'
        end
      end

      resources :courses do
        resources :storages, only: [:create, :delete]
        resources :course_phases, only: [:index, :show, :update], path: 'phases' do
          resources :storages
          get 'preferences/:role' => 'course_phases#preferences'
        end
        get 'phase/active' => 'course_phases#active'
        collection do
          get ':id/participants' => 'courses#participants'
        end
      end
    end
  end
end
