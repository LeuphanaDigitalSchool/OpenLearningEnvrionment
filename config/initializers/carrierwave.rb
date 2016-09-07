# frozen_string_literal: true
CarrierWave.configure do |config|
  config.enable_processing = false if Rails.env.test?
  config.asset_host = Settings.asset_host
end
