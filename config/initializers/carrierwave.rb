CarrierWave.configure do |config|
  config.storage = :file
  config.root = Rails.root.join('tmp')
  config.cache_dir = "uploads"
  config.grid_fs_access_url = "/images"
  config.grid_fs_access_url = "/systems/uploads"
end
