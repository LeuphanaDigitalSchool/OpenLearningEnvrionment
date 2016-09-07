# frozen_string_literal: true
require 'rails_helper'

resource 'Api::V1::Admin::Users::Users' do
  let!(:user) { FactoryGirl.create(:user, :course_manager) }

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  get '/api/v1/admin/users/profile_selects' do
    example '#profile_selects' do
      do_request
      expect(response_body).to include('genders', 'educational_attainments')
      expect(response_status).to be 200
    end
  end

  get '/api/v1/admin/users' do
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
      expect(response_status).to be 200
    end
  end

  delete '/api/v1/admin/users/users/:id' do
    parameter :id, 'User id', required: true
    parameter :deleted, 'Delete/deactivate user', required: false

    let(:raw_post) { params.to_json }
    let(:user_params) do
      { 'id': user.id }
    end

    example '#delete (request not authorized)', document: false do
      do_request(user_params)
      expect(response_body).to include('errors')
      expect(response_status).to be 401
    end

    example '#delete (request authorized)' do
      login(user)
      do_request(user_params)
      expect(response_status).to be 204
    end
  end
end
