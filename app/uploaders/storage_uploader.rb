# encoding: utf-8
# frozen_string_literal: true
# StorageUploader
class StorageUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end

  def extension_white_list
    model.upload_whitelist
  end

  def filename
    if original_filename
      timestamp = Time.now.strftime('%Y%m%d%H%M%S')
      extension = File.extname(file.file)
      "#{timestamp}#{extension}"
    end
  end
end
