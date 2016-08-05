# frozen_string_literal: true
require 'rails_helper'

resource 'Api::V1::Admin::CourseDirectors' do
  before { FactoryGirl.create(:user, :course_director) }
  let!(:user) { FactoryGirl.create(:user, :course_manager) }

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  get '/api/v1/admin/course_directors' do
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

  post '/api/v1/admin/course_directors' do
    parameter :title, 'Title', required: false
    parameter :firstname, 'Firstname', required: false
    parameter :lastname, 'Lastname', required: false
    parameter :gender, 'Gender', required: false
    parameter :country, 'country', required: false
    parameter :age, 'Age', required: false
    parameter :educational_attainment, 'Educational attainment', required: false
    parameter :profession, 'Profession', required: false
    parameter :avatar, 'Avatar', required: false
    parameter :interests, 'Interests', required: false
    parameter :introduction, 'Introduction', required: false
    parameter :email, 'E-mail', required: false
    parameter :password, 'Password', required: true
    parameter :password_confirmation, 'Password confirmation', required: true

    before { login(user) }
    let(:raw_post) { params.to_json }

    example '#create (empty parameters)', document: false do
      no_doc do
        do_request(course_director_empty_params)
        expect(response_status).to be 422
      end
    end

    example '#create (course director created)' do
      params = { "course_director": { "title": 'Course director', "firstname": 'Sylwia', "lastname": 'Kocyk',
                                      "gender": '1', "country": 'DE', "age": '24', "educational_attainment": '5',
                                      "profession": 'Master', "avatar": '', "interests": '', "introduction": '',
                                      "email": 'example_course_director@example.com', "password": 'course_director1234',
                                      "password_confirmation": 'course_director1234' } }
      do_request(params)
      expect(response_status).to be 201
    end
  end

  private

  def course_director_empty_params
    { 'course_director': { 'title': '' } }
  end
end
