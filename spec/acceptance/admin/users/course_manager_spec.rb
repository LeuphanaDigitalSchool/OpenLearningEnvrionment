# frozen_string_literal: true
require 'rails_helper'

resource 'Api::V1::Admin::Users::CourseManager' do
  before { FactoryGirl.create(:user, :course_manager) }
  let(:course_manager) { FactoryGirl.create(:user, :course_manager) }
  let!(:user) { FactoryGirl.create(:user, :course_manager) }

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  get '/api/v1/admin/users/course_managers' do
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

  post '/api/v1/admin/users/course_managers' do
    parameter :title, 'Title', required: false
    parameter :firstname, 'Firstname', required: true
    parameter :lastname, 'Lastname', required: true
    parameter :gender, 'Gender', required: false
    parameter :country, 'country', required: false
    parameter :birthdate, 'Date of birth', required: false
    parameter :educational_attainment, 'Educational attainment', required: false
    parameter :profession, 'Profession', required: false
    parameter :avatar, 'Avatar', required: false
    parameter :interests, 'Interests', required: false
    parameter :introduction, 'Introduction', required: false
    parameter :email, 'E-mail', required: true
    parameter :password, 'Password', required: true
    parameter :password_confirmation, 'Password confirmation', required: true

    before { login(user) }
    let(:raw_post) { params.to_json }

    example '#create (empty parameters)', document: false do
      no_doc do
        do_request(course_manager_empty_params)
        expect(response_status).to be 422
      end
    end

    example '#create (course manager created)' do
      params = { "course_manager": { "title": 'Course manager', "firstname": 'Sylwia', "lastname": 'Kocyk',
                                     "gender": '1', "country": 'DE', "birthdate": '1990-01-01', "introduction": '',
                                     "educational_attainment": '5', "profession": 'Master', "interests": '',
                                     "email": 'example_course_director@example.com', "password": 'course_manager1234',
                                     "password_confirmation": 'course_manager1234',
                                     "avatar": 'data:image/gif;base64,R0lGODlhAQABAIABAAP///yH5BAEAAAAAAEAAAIBRAA7' } }
      do_request(params)
      expect(JSON.parse(response_body).to_s).to include('Course manager', 'Sylwia', 'Kocyk', 'size_256x256_')
      expect(response_status).to be 201
    end
  end

  get '/api/v1/admin/users/course_managers/:id' do
    parameter :id, 'Course manager id', required: true

    example '#show (request not authorized)', document: false do
      no_doc do
        do_request(id: course_manager.id)
        expect(response_body).to include('errors')
        expect(response_status).to be 401
      end
    end

    example '#show (request authorized)' do
      login(user)
      do_request(id: course_manager.id)
      expect(response_body).to include('Jola', 'Mis', 'role')
    end
  end

  put '/api/v1/admin/users/course_managers/:id' do
    parameter :id, 'Course manager id', required: true
    parameter :title, 'Title', required: false
    parameter :firstname, 'Firstname', required: true
    parameter :lastname, 'Lastname', required: true
    parameter :gender, 'Gender', required: false
    parameter :country, 'country', required: false
    parameter :birthdate, 'Date of birth', required: false
    parameter :educational_attainment, 'Educational attainment', required: false
    parameter :profession, 'Profession', required: false
    parameter :avatar, 'Avatar', required: false
    parameter :interests, 'Interests', required: false
    parameter :introduction, 'Introduction', required: false
    parameter :email, 'E-mail', required: true
    parameter :password, 'Password', required: true
    parameter :password_confirmation, 'Password confirmation', required: true

    let(:raw_post) { params.to_json }
    let(:course_manager_params) do
      { 'id': course_manager.id, 'course_manager': { 'firstname': 'Dexter', 'lastname': 'Morgan', 'title': 'Killer',
                                                     'interests': 'Cut cut cut!' } }
    end

    example '#update (request not authorized)', document: false do
      do_request(course_manager_params)
      expect(response_body).to include('errors')
      expect(response_status).to be 401
    end

    example '#update (request authorized)' do
      login(user)
      do_request(course_manager_params)
      expect(response_body).to include('Dexter', 'Morgan')
      expect(response_status).to be 200
    end
  end

  delete '/api/v1/admin/users/course_managers/:id' do
    parameter :id, 'Course manager id', required: true
    parameter :deleted, 'Delete/deactivate course manager', required: false

    let(:raw_post) { params.to_json }
    let(:course_manager_params) do
      { 'id': course_manager.id, 'course_manager': { 'deleted': 'true' } }
    end

    example '#delete (request not authorized)', document: false do
      do_request(course_manager_params)
      expect(response_body).to include('errors')
      expect(response_status).to be 401
    end

    example '#delete (request authorized)' do
      login(user)
      do_request(course_manager_params)
      expect(response_status).to be 204
    end
  end

  private

  def course_manager_empty_params
    { 'course_manager': { 'firstname': '' } }
  end
end
