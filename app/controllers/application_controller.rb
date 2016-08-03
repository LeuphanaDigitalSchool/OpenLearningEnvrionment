# frozen_string_literal: true
# ApplicationController
class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Serialization
  include Locale
end
