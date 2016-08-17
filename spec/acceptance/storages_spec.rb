# frozen_string_literal: true
require 'rails_helper'

resource 'Api::V1::Storages' do
  before { FactoryGirl.create(:storage) }
  before { FactoryGirl.create(:user, :course_director) }
  let(:course_director) { FactoryGirl.create(:user, :course_director) }
  let!(:user) { FactoryGirl.create(:user, :course_manager) }
  let(:storage) { FactoryGirl.create(:storage) }
  let(:course) { FactoryGirl.create(:course) }
  let(:course_id) { course.id }
  let(:storage_id) { storage.id }

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  get '/api/v1/courses/:course_id/storages' do
    example '#index (request not authorized)', document: false do
      do_request
      expect(response_body).to include('errors')
      expect(response_status).to be 401
    end

    example '#index (request authorized)' do
      login(user)
      do_request
      expect(response_body).to include('storage')
      expect(response_status).to be 200
    end
  end

  post '/api/v1/courses/:course_id/storages' do
    parameter :source, 'Youtube', required: true
    parameter :name, 'Yt link', required: false
    parameter :url, 'https://www.youtube.com/watch?v=u_tORtmKIjE', required: false
    parameter :course_id, :course_id, required: false
    parameter :user_id, 1, required: false

    before { login(user) }
    let(:raw_post) { params.to_json }

    example '#create (storage created)' do
      params = { "storage": { "source": 'Youtube', "name": 'Yt link',
                              "url": 'https://www.youtube.com/watch?v=u_tORtmKIjE', "course_id": :course_id,
                              "user_id": 1 } }
      do_request(params)
      expect(JSON.parse(response_body).to_s).to include('Youtube', 'Yt link',
                                                        'https://www.youtube.com/watch?v=u_tORtmKIjE')
      expect(response_status).to be 201
    end
  end

  get '/api/v1/courses/:course_id/storages/:storage_id' do
    example '#show (request not authorized)', document: false do
      do_request
      expect(response_body).to include('errors')
      expect(response_status).to be 401
    end

    example '#show (request authorized)' do
      login(user)
      do_request
      expect(response_status).to be 200
    end
  end

  put '/api/v1/courses/:course_id/storages/:storage_id' do
    parameter :source, 'Youtube', required: true
    parameter :name, 'Yt link', required: false
    parameter :url, 'https://www.youtube.com/watch?v=u_tORtmKIjE', required: false
    parameter :course_id, :course_id, required: false
    parameter :user_id, 1, required: false

    let(:raw_post) { params.to_json }
    let(:storage_params) do
      { "id": storage.id, "storage": { "source": 'Youtube', "name": 'Yt link',
                                       "url": 'https://www.youtube.com/watch?v=u_tORtmKIjE',
                                       "course_id": :course_id, "user_id": 1 } }
    end

    example '#update (request not authorized)', document: false do
      do_request(storage_params)
      expect(response_body).to include('errors')
      expect(response_status).to be 401
    end

    example '#update (request authorized)' do
      login(user)
      do_request(storage_params)
      expect(response_status).to be 200
    end
  end

  delete '/api/v1/courses/:course_id/storages/:storage_id' do
    parameter :deleted, 'Delete/deactivate storage', required: false

    let(:raw_post) { params.to_json }
    let(:storage_params) do
      { 'id': storage.id, 'storage': { 'deleted': 'true' } }
    end

    example '#delete (request not authorized)', document: false do
      do_request(storage_params)
      expect(response_body).to include('errors')
      expect(response_status).to be 401
    end

    example '#delete (request authorized)' do
      login(user)
      do_request(storage_params)
      expect(response_status).to be 204
    end
  end
end
