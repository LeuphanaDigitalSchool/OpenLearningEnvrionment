# frozen_string_literal: true
require 'rails_helper'

resource 'Api::V1::Auth' do
  let!(:user) { FactoryGirl.create(:user, :course_manager) }

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  post '/api/v1/auth' do
    parameter :email, 'Email', required: true
    parameter :password, 'Password', required: true
    parameter :title, 'Title', required: false
    parameter :firstname, 'Firstname', required: false
    parameter :lastname, 'Lastname', required: false
    parameter :terms_and_conditions, 'Terms and conditions', required: true
    parameter :data_privacy, 'Data privacy', required: true

    let(:raw_post) { params.to_json }
    example '#signup public user without params', document: false do
      do_request
      expect(response_status).to be 422
    end

    example '#signup public user without checked terms', document: false do
      params = {  "email": 'jola@mis.com', "password": 'user1234', "title": 'Public user', "firstname": 'Public',
                  "lastname": 'user', "terms_and_conditions": false, "data_privacy": true }
      do_request(params)
      expect(response_status).to be 422
    end

    example '#signup public user with checked terms' do
      params = {  "email": 'jola@mis.com', "password": 'user1234', "title": 'Public user', "firstname": 'Public',
                  "lastname": 'user', "terms_and_conditions": true, "data_privacy": true }
      do_request(params)
      expect(response_status).to be 200
    end
  end

  post '/api/v1/auth/sign_in' do
    parameter :email, 'Email', required: true
    parameter :password, 'Password', required: true

    let(:raw_post) { params.to_json }
    example '#login' do
      do_request('email': user.email,
                 'password': user.password)
      expect(response_headers).to include 'access-token'
      expect(response_status).to be 200
    end

    example '#login unauthorized error empty params', document: false do
      explanation 'empty parameters'
      do_request
      expect(response_status).to be 401
    end

    example '#login unauthorized error wrong params', document: false do
      explanation 'wrong parameters'
      do_request('email': 'wrong@email.com',
                 'password': 'wrong_password')
      expect(response_status).to be 401
    end
  end

  get '/api/v1/auth/sign_in' do
    example '#login method not allowed', document: false do
      explanation 'when request get instead of post'
      do_request
      expect(response_status).to be 405
    end
  end

  get '/api/v1/auth/validate_token' do
    example '#validate_token' do
      explanation 'user is login'
      login(user)
      do_request
      expect(response_status).to be 200
    end

    example '#validate_token unauthorized error', document: false do
      explanation 'user is logout'
      do_request
      expect(response_status).to be 401
    end
  end

  delete '/api/v1/auth/sign_out' do
    example '#logout', document: false do
      explanation 'logout when user is login'
      login(user)
      do_request
      expect(response_status).to be 200
    end

    example '#logout not found error', document: false do
      explanation 'logout when user is logout'
      do_request
      expect(response_status).to be 404
    end
  end

  post '/api/v1/auth/password' do
    parameter :email, 'Email related to account', required: true
    parameter :redirect_url, 'Url with reset form', required: true

    let(:raw_post) { params.to_json }
    example '#create new password' do
      explanation 'send email with token'
      do_request('email': user.email,
                 'redirect_url': 'localhost:8080')
      expect(ActionMailer::Base.deliveries.last.body).to match 'reset_password_token'
    end
  end

  get '/api/v1/auth/password/edit?reset_password_token=:token&redirect_url=/:redirect_url' do
    let(:token) { create_reset_password_token(user) }
    let(:redirect_url) { 'localhost:8080' }
    example '#reset_password (get tokens)' do
      do_request
      expect(response_body).to match('client_id')
      expect(response_body).to match('reset_password')
      expect(response_body).to match('token')
    end
  end

  put '/api/v1/auth/password' do
    parameter :password
    parameter :password_confirmation

    let(:raw_post) { params.to_json }
    example '#reset_password (set new password)' do
      login(user)
      do_request(password: 'admin1234', password_confirmation: 'admin1234')
      expect(response_body).to include('Your password has been successfully updated.')
      expect(response_status).to be 200
    end
  end

  put '/api/v1/auth/invitation' do
    params = {
      "invitation_token": 'eY3n1YrcJ_yypn2pf9Py',
      "user":
      {
        "password": 'admin1234',
        "password_confirmation": 'admin1234',
        "interests": 'abba',
        "gender": '1',
        "title": 'pdh',
        "country": 'pl',
        "educational_attainment": '3',
        "profession": 'vcx',
        "introduction": 'asd',
        "avatar": 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7',
        "data_privacy": 'true',
        "terms_and_conditions": 'true',
        "honor_code": 'true',
        "birthdate": '1995-05-05'
      }
    }

    let(:raw_post) { params.to_json }
    example '#accept invitation' do
      login(user)
      do_request(params)
    end
  end
end
