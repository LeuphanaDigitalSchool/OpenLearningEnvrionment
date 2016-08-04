# frozen_string_literal: true

describe 'Devise', type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_params) { { 'email': user.email, 'password': user.password } }

  describe 'POST /api/v1/auth' do
    context 'if request has wrong params' do
      it 'should return status 422' do
        post '/api/v1/auth'
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'POST /api/v1/auth' do
    context 'if request has correct params' do
      it 'should return status 200 OK' do
        params = { 'email': 'test@testing.com', 'password': 'admin1234', 'title': 'Title', 'firstname': 'Andrij',
                   'lastname': 'Kliczko', 'honor_code': 'true', 'terms_and_conditions': 'true', 'data_privacy': 'true' }
        post '/api/v1/auth', params: params.to_json, headers: { 'CONTENT_TYPE': 'application/json' }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /api/v1/auth/sign_in' do
    context 'if request has wrong method' do
      it 'should return status 405' do
        get '/api/v1/auth/sign_in'
        expect(response).to have_http_status(405)
      end
    end
  end

  describe 'POST /api/v1/auth/sign_in' do
    before(:each) do
      post '/api/v1/auth/sign_in'
    end

    context 'if request is not authorized' do
      context 'should return status 401 when send' do
        it 'empty access data' do
          expect(response).to have_http_status(401)
        end

        it 'incorrect access data' do
          params = { 'email': 'incorrect@example.com', 'password': 'incorrect' }
          post '/api/v1/auth/sign_in', params: params.to_json, headers: { 'CONTENT_TYPE': 'application/json' }
          expect(response).to have_http_status(401)
        end
      end
    end

    context 'if request is authorized' do
      it 'should return status 200' do
        post '/api/v1/auth/sign_in', params: user_params.to_json, headers: { 'CONTENT_TYPE': 'application/json' }
        expect(response).to have_http_status(200)
        expect(response.header['uid']).not_to be_empty
        expect(response.header['client']).not_to be_empty
        expect(response.header['access-token']).not_to be_empty
      end
    end
  end

  describe 'POST /api/v1/auth/validate_token' do
    it 'should return status 200 and success true when valid token' do
      post '/api/v1/auth/sign_in', params: user_params.to_json, headers: { 'CONTENT_TYPE': 'application/json' }
      get '/api/v1/auth/validate_token', params: {}, headers: request_headers(response)
      expect(JSON.parse(response.body)['success']).to be true
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/v1/auth/sign_out' do
    context 'if request logout successfull'
    it 'should return status 200 and success true' do
      post '/api/v1/auth/sign_in', params: user_params.to_json, headers: { 'CONTENT_TYPE': 'application/json' }
      expect(response).to have_http_status(200)
      delete '/api/v1/auth/sign_out', params: {}, headers: request_headers(response)
      expect(JSON.parse(response.body)['success']).to be true
      expect(response).to have_http_status(200)
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
