# frozen_string_literal: true
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = :json
end

def login(user)
  user.create_new_auth_token.each do |header_key, header_value|
    header header_key, header_value
  end
end

def create_reset_password_token(user)
  user.send_reset_password_instructions
end
