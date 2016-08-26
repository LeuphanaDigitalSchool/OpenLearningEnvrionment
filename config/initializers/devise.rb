# frozen_string_literal: true
Devise.setup do |config|
  config.mailer_sender = Settings.default_email
end
