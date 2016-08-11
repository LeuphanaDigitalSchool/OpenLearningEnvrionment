# frozen_string_literal: true
require 'rails_helper'

resource 'Api::V1::Courses' do
  before { FactoryGirl.create(:course) }
  before { FactoryGirl.create(:user, :course_director) }
  let(:course_director) { FactoryGirl.create(:user, :course_director) }
  let!(:user) { FactoryGirl.create(:user, :course_manager) }
  let(:course) { FactoryGirl.create(:course) }

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  get '/api/v1/courses' do
    example '#index (request not authorized)', document: false do
      do_request
      expect(response_body).to include('errors')
      expect(response_status).to be 401
    end

    example '#index (request authorized)' do
      login(user)
      do_request
      expect(response_body).to include('course')
      expect(response_status).to be 200
    end
  end

  post '/api/v1/courses' do
    parameter :title, 'Title', required: true
    parameter :description, 'Description', required: false
    parameter :start_date, '2016-08-07', required: false
    parameter :end_date, '2017-08-08', required: false

    before { login(user) }
    let(:raw_post) { params.to_json }

    example '#create (course created)' do
      params = { "course": { "title": 'Pierwszy kurs', "description": 'Opis kursu', "start_date": '2016-01-01',
                             "end_date": '2017-02-03' } }
      do_request(params)
      expect(JSON.parse(response_body).to_s).to include('Pierwszy kurs', 'Opis kursu', '2016-01-01', '2017-02-03')
      expect(response_status).to be 201
    end
  end

  get '/api/v1/courses/:id' do
    parameter :id, 'Course id', required: true

    example '#show (request not authorized)', document: false do
      do_request(id: course.id)
      expect(response_body).to include('errors')
      expect(response_status).to be 401
    end

    example '#show (request authorized)' do
      login(user)
      do_request(id: course.id)
      expect(response_body).to include('Example course', 'Course description', '2016-08-11', '2017-08-11')
      expect(response_status).to be 200
    end
  end

  put '/api/v1/courses/:id' do
    parameter :title, 'Title', required: true
    parameter :description, 'Description', required: false
    parameter :start_date, '2016-08-07', required: false
    parameter :end_date, '2017-08-08', required: false

    let(:raw_post) { params.to_json }
    let(:course_params) do
      { "id": course.id, "course": { "title": 'Pierwszy kurs', "description": 'Opis kursu', "start_date": '2016-01-01',
                                     "end_date": '2017-02-03' } }
    end

    example '#update (request not authorized)', document: false do
      do_request(course_params)
      expect(response_body).to include('errors')
      expect(response_status).to be 401
    end

    example '#update (request authorized)' do
      login(user)
      do_request(course_params)
      expect(response_body).to include('Pierwszy kurs', 'Opis kursu')
      expect(response_status).to be 200
    end
  end

  delete '/api/v1/courses/:id' do
    parameter :id, 'Course id', required: true
    parameter :deleted, 'Delete/deactivate course', required: false

    let(:raw_post) { params.to_json }
    let(:course_params) do
      { 'id': course.id, 'course': { 'deleted': 'true' } }
    end

    example '#delete (request not authorized)', document: false do
      do_request(course_params)
      expect(response_body).to include('errors')
      expect(response_status).to be 401
    end

    example '#delete (request authorized)' do
      login(user)
      do_request(course_params)
      expect(response_status).to be 204
    end
  end
end
