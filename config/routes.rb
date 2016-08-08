# frozen_string_literal: true
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1, except: [:new, :edit] do
      mount_devise_token_auth_for 'User', at: 'auth'
      get 'locales' => 'locales#index'

      namespace :admin do
        get 'users/profile_selects'
        resources :teachers, :supports, :course_directors, :students
      end
    end
  end
end
