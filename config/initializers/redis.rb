if ENV['REDISTOGO_URL']
  uri = URI.parse(ENV['REDISTOGO_URL'])
  REDIS_WORKER = Redis.new(host: uri.host, port: uri.port, password: uri.password)
end
