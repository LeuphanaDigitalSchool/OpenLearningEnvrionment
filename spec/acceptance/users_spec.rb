# frozen_string_literal: true
require 'rails_helper'

resource 'Api::V1::Users' do
  let!(:user) { FactoryGirl.create(:user, :course_manager) }

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  get '/api/v1/profile/:id' do
    parameter :id, 'User id'
    example '#show (request not authorized)', document: false do
      no_doc do
        do_request(id: 1)
        expect(response_body).to include('errors')
        expect(response_status).to be 401
      end
    end

    example '#show (request authorized)' do
      login(user)
      do_request(id: 1)
      expect(response_status).to be 200
    end
  end
end
