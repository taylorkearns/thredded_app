if defined? Airbrake
  Airbrake.configure do |config|
    config.api_key = ENV['ERRBIT_KEY']
    config.host    = 'thredded-errbit.herokuapp.com'
    config.port    = 80
    config.secure  = config.port == 443
  end
end
