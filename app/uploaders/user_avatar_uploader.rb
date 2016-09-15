# frozen_string_literal: true
# UserAvatarUploader
class UserAvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end

  version :size_256x256 do
    process resize_to_fill: [256, 265]
  end

  version :size_128x128 do
    process resize_to_fill: [128, 128]
  end

  version :size_64x64 do
    process resize_to_fill: [64, 64]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # def filename
  #   if original_filename
  #     timestamp = Time.now.strftime('%Y%m%d%H%M%S')
  #     extension = File.extname(file.file)
  #     "#{model.id}_#{timestamp}#{extension}"
  #   end
  # end
end
