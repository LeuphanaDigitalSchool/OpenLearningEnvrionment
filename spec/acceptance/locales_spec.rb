# frozen_string_literal: true
require 'rails_helper'
resource 'Api::V1::Locales' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  parameter :lang, 'Set language code'

  get '/api/v1/locales' do
    example '#locales (change locales to german for non-logged)' do
      explanation 'Change locales to german language'
      do_request(lang: 'de')
      expect(response_headers['user-language']).to eq('de'.to_sym)
      expect(response_status).to eq(200)
    end

    example '#locales (change locales to english for non-logged)' do
      explanation 'Change locales to english language'
      do_request(lang: 'en')
      expect(response_headers['user-language']).to eq('en'.to_sym)
      expect(response_status).to eq(200)
    end
  end

  get '/api/v1/locales' do
    let(:user) { FactoryGirl.create(:user, :public_user) }
    example '#locales (change locales to german for logged)' do
      login(user)
      do_request(lang: 'de')
      expect(response_headers['user-language']).to eq('de'.to_sym)
      expect(response_status).to eq(200)
    end

    example '#locales (change locales to english for logged)' do
      login(user)
      do_request(lang: 'en')
      expect(response_headers['user-language']).to eq('en'.to_sym)
      expect(response_status).to eq(200)
    end
  end
end
