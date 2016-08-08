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
end
