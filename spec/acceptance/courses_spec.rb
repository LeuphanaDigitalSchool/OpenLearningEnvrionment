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
      explanation 'Always add "course_phases_preferences_attributes" with "role_id" 2(student role) and 4(teacher role)'
      course_phase_preferences_attributes = [{ "role_id": '2', "upload_pdf": 'true', "upload_jpg": 'false',
                                               "upload_mp3": 'true', "upload_mp4": 'false', "resources_del": 'false',
                                               "resource_description_add": 'true', "resource_description_del": 'false',
                                               "schedule_publishing": 'true', "embed_external_links": 'true' },
                                             { "role_id": '4', "upload_pdf": 'true', "upload_jpg": 'true',
                                               "upload_mp3": 'false', "upload_mp4": 'true', "resources_del": 'false',
                                               "resource_description_add": 'true', "resource_description_del": 'false',
                                               "schedule_publishing": 'true', "embed_external_links": false }]
      course_phases_attributes = [{ "title": 'Phase 1', "start_date": '2016-09-01', "end_date": '2016-09-30',
                                    "course_phase_preferences_attributes": course_phase_preferences_attributes },
                                  { "title": 'Phase 2', "start_date": '2016-09-01', "end_date": '2016-09-30',
                                    "course_phase_preferences_attributes": course_phase_preferences_attributes },
                                  { "title": 'Phase 3', "start_date": '2016-10-01', "end_date": '2016-10-30',
                                    "course_phase_preferences_attributes": course_phase_preferences_attributes },
                                  { "title": 'Phase 4', "start_date": '2016-11-01', "end_date": '2016-11-30',
                                    "course_phase_preferences_attributes": course_phase_preferences_attributes },
                                  { "title": 'Phase 5', "start_date": '2016-12-01', "end_date": '2016-12-30',
                                    "course_phase_preferences_attributes": course_phase_preferences_attributes },
                                  { "title": 'Phase 6', "start_date": '2017-01-01', "end_date": '2017-01-30',
                                    "course_phase_preferences_attributes": course_phase_preferences_attributes }]
      params = { "course": { "title": 'Sample course', "description": 'Description', "start_date": '2016-01-01',
                             "end_date": '2017-02-03', "course_phases_attributes": course_phases_attributes } }

      do_request(params)
      expect(response_body).to include('"title":"Sample course"', '"description":"Description"',
                                       '"start_date":"2016-01-01"', '"end_date":"2017-02-03"', '"role":"Student"',
                                       '"title":"Phase 1"', '"role_id":2', '"upload":true', '"upload_pdf":true',
                                       '"upload_jpg":false', '"upload_mp3":true', '"upload_mp4":false',
                                       '"resource_description_add":true', '"resource_description_del":false',
                                       '"resources_del":false')
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

  get '/api/v1/courses/:id/participants' do
    parameter :id, 'Course id', required: true

    example '#participants (request not authorized)', document: false do
      do_request(id: course.id)
      expect(response_body).to include('errors')
      expect(response_status).to be 401
    end

    example '#participants (request authorized)' do
      login(user)
      do_request(id: course.id)
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
      { "id": '1', "course": { "title": 'Sample course edit',
                               "course_preferences_attributes": [{ "id": '1', "upload_pdf": 'true' },
                                                                 { "id": '2', "upload_mp3": 'true' }] } }
    end

    example '#update (request not authorized)', document: false do
      do_request(course_params)
      expect(response_body).to include('errors')
      expect(response_status).to be 401
    end

    example '#update (request authorized)' do
      login(user)
      do_request(course_params)
      expect(response_body).to include('Sample course', 'Sample description')
      expect(response_status).to be 200
    end
  end

  get '/api/v1/courses/:course_id/phases/:course_phase_id/preferences/:role' do
    parameter :course_id
    parameter :course_phase_id
    parameter :role

    let(:raw_post) { params.to_json }
    example '#preferences for teacher' do
      explanation 'Role params should be "teacher"'
      login(user)
      do_request(course_id: 1, course_phase_id: 1, role: 'teacher')
      expect(response_body).to include('Teacher')
      expect(response_status).to be 200
    end

    example '#preferences for student' do
      explanation 'Role params should be "student"'
      login(user)
      do_request(course_id: 1, course_phase_id: 1, role: 'student')
      expect(response_body).to include('Student')
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
