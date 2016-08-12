# frozen_string_literal: true
require 'rails_helper'

resource 'Api::V1::Conversations' do
  let!(:user) { FactoryGirl.create(:user, :course_manager) }
  let!(:user_2) { FactoryGirl.create(:user, :course_manager) }
  let!(:user_3) { FactoryGirl.create(:user, :course_manager) }
  let!(:user_4) { FactoryGirl.create(:user, :course_manager) }
  let!(:user_5) { FactoryGirl.create(:user, :course_manager) }

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  get '/api/v1/conversations' do
    example '#index (request authorized)' do
      explanation 'List of conversations'
      login(user)
      do_request
    end
  end

  post '/api/v1/conversations/sent' do
    parameter :recipients, 'Array of recipients ids'
    parameter :body, 'Message body'

    let(:raw_post) { params.to_json }
    example '#sent (request authorized) 1-1' do
      explanation 'Send message to new conversation with one recipient'
      login(user)
      params = { "conversation": { "recipients": user_2.id, "body": 'Single test' } }
      do_request(params)
      expect(response_body).to include('Single test')
    end
  end

  post '/api/v1/conversations/sent' do
    parameter :recipients, 'Array of recipients ids'
    parameter :body, 'Message body'

    let(:raw_post) { params.to_json }
    example '#sent (request authorized) 1-n' do
      explanation 'Send message to new conversation with multiple recipients'
      login(user)
      params = { "conversation": { "recipients": [user_2.id, user_3.id, user_4.id, user_5.id], "body": 'Multi test' } }
      do_request(params)
      expect(response_body).to include('Multi test')
    end
  end

  get '/api/v1/conversations/:id' do
    parameter :id, 'Conversation id'

    let(:raw_post) { params.to_json }
    example '#show (request authorized)' do
      explanation 'Show messages from conversation'
      login(user)
      conversation = user.send_message(user_2, 'Body test', 'Subject').conversation
      user_2.reply_to_conversation conversation, 'User 2 test'
      user_3.reply_to_conversation conversation, 'User 3 test'
      params = { "id": conversation.id }
      do_request(params)
      expect(response_body).to include('Body test')
    end
  end

  post '/api/v1/conversations/:id/reply' do
    parameter :id, 'Conversation id'
    parameter :body, 'Message body'

    let(:raw_post) { params.to_json }
    example '#reply (request authorized)' do
      explanation 'Reply in conversation'
      login(user)
      conversation = user_2.send_message(user, 'Subject', 'Test').conversation
      params = { "id": conversation.id, "message": { "body": 'testing' } }
      do_request(params)
      expect(response_body).to include('testing')
    end
  end
end
