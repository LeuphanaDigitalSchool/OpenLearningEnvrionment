# frozen_string_literal: true
require 'rails_helper'

resource 'Api::V1::Admin::Users::Users' do
  let!(:user) { FactoryGirl.create(:user, :course_manager) }

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  get '/api/v1/admin/users/profile_selects' do
    example '#profile_selects (request not authorized)', document: false do
      no_doc do
        do_request
        expect(response_body).to include('errors')
        expect(response_status).to be 401
      end
    end

    example '#profile_selects (request authorized)' do
      login(user)
      do_request
      expect(response_body).to include('genders', 'educational_attainments')
      expect(response_status).to be 200
    end
  end
end
