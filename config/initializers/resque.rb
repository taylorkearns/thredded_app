if defined? REDIS_WORKER
  Resque.redis = REDIS_WORKER
end
