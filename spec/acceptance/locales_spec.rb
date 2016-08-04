# frozen_string_literal: true
require 'rails_helper'

resource 'Api::V1::Locales' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  parameter :lang, 'Set language code'

  get '/api/v1/locales' do
    example '#non-logged #change locales to polish' do
      explanation 'Change locales to polish language'
      do_request(lang: 'pl')
      expect(response_headers['user-language']).to eq('pl'.to_sym)
      expect(response_status).to eq(200)
    end

    example '#non-logged #change locales to english' do
      explanation 'Change locales to english language'
      do_request(lang: 'en')
      expect(response_headers['user-language']).to eq('en'.to_sym)
      expect(response_status).to eq(200)
    end
  end

  get '/api/v1/locales' do
    let(:user) { FactoryGirl.create(:user) }

    example '#logged #change locales to polish' do
      login(user)
      do_request(lang: 'pl')
      expect(response_headers['user-language']).to eq('pl'.to_sym)
      expect(response_status).to eq(200)
    end

    example '#logged #change locales to english' do
      login(user)
      do_request(lang: 'en')
      expect(response_headers['user-language']).to eq('en'.to_sym)
      expect(response_status).to eq(200)
    end
  end
end
