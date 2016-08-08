# frozen_string_literal: true
require 'rails_helper'

resource 'Api::V1::Admin::Users::Students' do
  before { FactoryGirl.create(:user, :student) }
  let(:student) { FactoryGirl.create(:user, :student) }
  let!(:user) { FactoryGirl.create(:user, :course_manager) }

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  get '/api/v1/admin/users/students' do
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

  post '/api/v1/admin/users/students' do
    parameter :title, 'Title', required: false
    parameter :firstname, 'Firstname', required: true
    parameter :lastname, 'Lastname', required: true
    parameter :gender, 'Gender', required: true
    parameter :country, 'country', required: true
    parameter :birthdate, 'Date of birth', required: true
    parameter :educational_attainment, 'Educational attainment', required: false
    parameter :profession, 'Profession', required: false
    parameter :avatar, 'Avatar', required: false
    parameter :interests, 'Interests', required: false
    parameter :introduction, 'Introduction', required: false
    parameter :email, 'E-mail', required: false
    parameter :password, 'Password', required: true
    parameter :password_confirmation, 'Password confirmation', required: true
    parameter :data_privacy, 'Data privacy', required: true
    parameter :terms_and_conditions, 'Terms and conditions', required: true
    parameter :honor_code, 'Honor code', required: true

    before { login(user) }
    let(:raw_post) { params.to_json }

    example '#create (empty parameters)', document: false do
      no_doc do
        do_request(student_empty_params)
        expect(response_status).to be 422
      end
    end

    example '#create (student created)' do
      params = { "student": { "title": 'Student', "firstname": 'Angelika', "lastname": 'Blokers', "gender": '1',
                              "country": 'PL', "birthdate": '1995-05-05', "educational_attainment": '3',
                              "interests": '', "introduction": '', "email": 'example_student@example.com',
                              "password": 'student1234', "password_confirmation": 'student1234', "profession": '',
                              "avatar": 'data:image/gif;base64,R0lGODlhAQABAIABAAP///yH5BAEAAAAAAEAAAIBRAA7',
                              "data_privacy": 'true', "terms_and_conditions": 'true', "honor_code": 'true' } }
      do_request(params)
      expect(JSON.parse(response_body).to_s).to include('Student', 'Angelika', 'Blokers', 'size_128x128_')
      expect(response_status).to be 201
    end
  end

  get '/api/v1/admin/users/students/:id' do
    parameter :id, 'Student id', required: true

    example '#index (request not authorized)', document: false do
      no_doc do
        do_request(id: student.id)
        expect(response_body).to include('errors')
        expect(response_status).to be 401
      end
    end

    example '#show (request authorized)' do
      login(user)
      do_request(id: student.id)
      expect(response_body).to include('Jola', 'Mis', 'role')
    end
  end

  private

  def student_empty_params
    { 'student': { 'firstname': '', 'lastname': '' } }
  end
end
