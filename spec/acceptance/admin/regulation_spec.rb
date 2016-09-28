# frozen_string_literal: true
require 'rails_helper'

resource 'Api::V1::Admin::Regulations' do
  before { FactoryGirl.create(:regulation) }
  before { FactoryGirl.create(:user, :course_director) }
  let!(:user) { FactoryGirl.create(:user, :course_manager) }
  let(:course_director) { FactoryGirl.create(:user, :course_director) }
  let(:regulation) { FactoryGirl.create(:regulation) }
  let(:id) { regulation.id }

  get '/api/v1/admin/regulations' do
    parameter :name, 'Regulation name', required: false
    parameter :file, 'File base64', required: true

    example '#index (request not authorized)', document: false do
      do_request
      expect(response_body).to include('errors')
      expect(response_status).to be 401
    end

    example '#index (request authorized)' do
      login(user)
      do_request
      expect(response_body).to include('regulations')
      expect(response_status).to be 200
    end
  end

  get '/api/v1/admin/regulations/:id' do
    parameter :name, 'Regulation name', required: false
    parameter :file, 'File base64', required: true

    example '#show regulations' do
      do_request
      expect(response_status).to be 200
    end
  end

  put '/api/v1/admin/regulations/:id' do
    parameter :name, 'Terms', required: false
    parameter :file, 'File base64', required: true

    let(:raw_post) { params.to_json }
    let(:regulation_params) do
      { "name": 'Terms2', "file": 'data:image/pdf;base64,R0lGODlhAQABAIAAAAA///yH5BAEAAAAALAAAAA' }
    end

    example '#update (request not authorized)', document: false do
      do_request(regulation_params)
      expect(response_body).to include('errors')
      expect(response_status).to be 401
    end

    example '#update (request authorized)' do
      login(user)
      do_request(regulation_params)
      expect(response_status).to be 200
    end
  end
end
