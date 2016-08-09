# frozen_string_literal: true
require 'rails_helper'

resource 'Api::V1::Admin::Users::PublicUsers' do
  before { FactoryGirl.create(:user, :public_user) }
  let(:public_user) { FactoryGirl.create(:user, :public_user) }
  let!(:user) { FactoryGirl.create(:user, :course_manager) }

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  get '/api/v1/admin/users/public_users' do
    example '#index (request not authorized)', document: false do
      no_doc do
        do_request
        expect(response_body).to include('errors')
        expect(response_status).to be 401
      end
    end

    example '#index (request authorized)' do
      login(user)
      do_request
      expect(response_body).to include('role')
      expect(response_status).to be 200
    end
  end

  get '/api/v1/admin/users/public_users/:id' do
    parameter :id, 'Public User id', required: true

    example '#show (request not authorized)', document: false do
      no_doc do
        do_request(id: public_user.id)
        expect(response_body).to include('errors')
        expect(response_status).to be 401
      end
    end

    example '#show (request authorized)' do
      login(user)
      do_request(id: public_user.id)
      expect(response_body).to include('Jola', 'Mis', 'role')
    end
  end

  put '/api/v1/admin/users/public_users/:id' do
    parameter :id, 'Public user id', required: true
    parameter :firstname, 'Firstname', required: true
    parameter :lastname, 'Lastname', required: true
    parameter :gender, 'Gender', required: false
    parameter :country, 'country', required: false
    parameter :birthdate, 'Date of birth', required: false
    parameter :avatar, 'Avatar', required: false
    parameter :interests, 'Interests', required: false
    parameter :introduction, 'Introduction', required: false
    parameter :email, 'E-mail', required: false
    parameter :password, 'Password', required: true
    parameter :password_confirmation, 'Password confirmation', required: true

    let(:raw_post) { params.to_json }
    let(:public_user_params) do
      { 'id': public_user.id, 'public_user': { 'firstname': 'Harley', 'lastname': 'Quinn', 'title': 'Queen' } }
    end

    example '#update (request not authorized)', document: false do
      do_request(public_user_params)
      expect(response_body).to include('errors')
      expect(response_status).to be 401
    end

    example '#update (request authorized)' do
      login(user)
      do_request(public_user_params)
      expect(response_body).to include('Harley', 'Quinn')
      expect(response_status).to be 200
    end
  end

  delete '/api/v1/admin/users/public_users/:id' do
    parameter :id, 'Public user id', required: true
    parameter :deleted, 'Delete/deactivate public user', required: false

    let(:raw_post) { params.to_json }
    let(:public_user_params) do
      { 'id': public_user.id, 'public_user': { 'deleted': 'true' } }
    end

    example '#delete (request not authorized)', document: false do
      do_request(public_user_params)
      expect(response_body).to include('errors')
      expect(response_status).to be 401
    end

    example '#delete (request authorized)' do
      login(user)
      do_request(public_user_params)
      expect(response_status).to be 204
    end
  end
end
