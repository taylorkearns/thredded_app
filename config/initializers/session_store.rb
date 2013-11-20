if Rails.env.staging? || Rails.env.production?
  Thredded::Application.config.session_store ActionDispatch::Session::CacheStore, expire_after: 1.day
else
  Thredded::Application.config.session_store :cookie_store, key: '_thredded_session'
end
