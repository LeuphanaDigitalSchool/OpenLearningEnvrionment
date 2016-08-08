# frozen_string_literal: true
require 'rails_helper'

resource 'Api::V1::Admin::Supports' do
  before { FactoryGirl.create(:user, :support) }
  let!(:user) { FactoryGirl.create(:user, :course_manager) }

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  get '/api/v1/admin/supports' do
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

  post '/api/v1/admin/supports' do
    parameter :title, 'Title', required: false
    parameter :firstname, 'Firstname', required: false
    parameter :lastname, 'Lastname', required: false
    parameter :gender, 'Gender', required: false
    parameter :country, 'country', required: false
    parameter :birthdate, 'Date of birth', required: false
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
        do_request(support_empty_params)
        expect(response_status).to be 422
      end
    end

    example '#create (support created)' do
      params = { "support": { "title": 'Support', "firstname": 'Sylwia', "lastname": 'Kocyk', "gender": '1',
                              "country": 'DE', "birthdate": '1998-06-06', "educational_attainment": '5',
                              "interests": '', "introduction": '', "email": 'example_support@example.com',
                              "password": 'support1234', "password_confirmation": 'support1234', "profession": 'Master',
                              "avatar": 'data:image/gif;base64,R0lGODlhAQABAIABAAP///yH5BAEAAAAAAEAAAIBRAA7' } }
      do_request(params)
      expect(JSON.parse(response_body).to_s).to include('Support', 'Sylwia', 'Kocyk', 'size_128x128_')
      expect(response_status).to be 201
    end
  end

  private

  def support_empty_params
    { 'support': { 'title': '' } }
  end
end
