Apipie.configure do |config|
  config.app_name                = "Bowling"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apipie"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.app_info                = "A RESTful application for scoring a bowling game"
  config.validate                = false
end
