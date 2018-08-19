Apipie.configure do |config|
  config.app_name                = 'Images API'
  config.api_base_url            = '/'
  config.doc_base_url            = '/docs'
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.app_info                = 'Simple image resize app.'
  config.translate               = false
end
