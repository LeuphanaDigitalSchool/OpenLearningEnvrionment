# frozen_string_literal: true
require 'rails_helper'

resource 'Api::V1::Admin::Regulations' do
  before { FactoryGirl.create(:regulation) }
  before { FactoryGirl.create(:user, :course_director) }
  let!(:user) { FactoryGirl.create(:user, :course_manager) }
  let(:course_director) { FactoryGirl.create(:user, :course_director) }
  let(:regulation) { FactoryGirl.create(:regulation) }
  let(:id) { regulation.id }

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  post '/api/v1/admin/regulations' do
    parameter :name, 'Regulation name', required: false
    parameter :file, 'File base64', required: true

    before { login(course_director) }
    let(:raw_post) { params.to_json }

    example '#create regulation' do
      explanation ''
      params = { "regulation": { "name": 'Term',
                                 "file": 'data:image/pdf;base64,R0lGODlhAQABAIAAAAA///yH5BAEAAAAALAAAAA' } }

      do_request(params)
      expect(JSON.parse(response_body).to_s).to include('Term')
      expect(response_status).to be 201
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
      { "id": regulation.id, "regulation": { "name": 'Terms',
                                             "file": 'data:image/pdf;base64,R0lGODlhAQABAIAAAAA///yH5BAEAAAAALAAAAA' } }
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
