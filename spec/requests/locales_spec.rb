# frozen_string_literal: true
require 'rails_helper'

describe 'Api::V1::Locales', type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_params) { { 'email': user.email, 'password': user.password } }

  describe '#index' do
    context 'user not signed in' do
      it 'change language to pl' do
        get '/api/v1/locales?lang=pl', params: {}, headers: { 'CONTENT_TYPE': 'application/json' }
        expect(response.header['user-language']).to eq('pl'.to_sym)
        expect(response).to have_http_status(200)
      end

      it 'change language to en' do
        get '/api/v1/locales?lang=en', params: {}, headers: { 'CONTENT_TYPE': 'application/json' }
        expect(response.header['user-language']).to eq('en'.to_sym)
        expect(response).to have_http_status(200)
      end
    end

    context 'user signed in' do
      it 'change language to pl' do
        post '/api/v1/auth/sign_in', params: user_params.to_json, headers: { 'CONTENT_TYPE': 'application/json' }
        get '/api/v1/locales?lang=pl', params: {}, headers: request_headers(response)
        expect(response.header['user-language']).to eq('pl'.to_sym)
        expect(response).to have_http_status(200)
      end

      it 'change language to en' do
        post '/api/v1/auth/sign_in', params: user_params.to_json, headers: { 'CONTENT_TYPE': 'application/json' }
        get '/api/v1/locales?lang=en', params: {}, headers: request_headers(response)
        expect(response.header['user-language']).to eq('en'.to_sym)
        expect(response).to have_http_status(200)
      end
    end
  end

  private

  def request_headers(response)
    {
      'CONTENT_TYPE': 'application/json',
      'access-token': response.header['access-token'],
      'client': response.header['client'],
      'uid': response.header['uid']
    }
  end
end
