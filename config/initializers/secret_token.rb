# Be sure to restart your server when you modify this file.


# Everyone can share the same token for development/test
if %w(development test).include? Rails.env
  Thredded::Application.config.secret_key_base =
    '303845a73bb5aa186e55b4ca642c4ac9a9cb4e3bf6869a48d048885a7dac20b8ce1bad102d90df67ec0bc56a6df31cde92c72f0a954185555a6b75f2d0cd0aef'
  Thredded::Application.config.secret_token =
    'e21d71a34f1b2e38a248c533e3803a903377beb453c5db0cb001f528dfd0ef30fd4e524cb8b438314ba1fa79108a0e85bca05086450412b9c015a6ef52ab5va8'

elsif ENV['SECRET_TOKEN'].present? && ENV['SECRET_KEY_BASE'].present?
  Thredded::Application.config.secret_key_base = ENV['SECRET_KEY_BASE']
  Thredded::Application.config.secret_token = ENV['SECRET_TOKEN']

else
  raise <<-ERROR.strip_heredoc
    You must generate a unique secret token for your Thredded instance.

    If you are deploying to Heroku, please run the following command to set your secret token:

        heroku config:add SECRET_KEY_BASE="$(bundle exec rake secret)"
        heroku config:add SECRET_TOKEN="$(bundle exec rake secret)"

    If you are deploying in some other way, please run the following command to generate a new secret token,
    and commit the new `config/initializers/secret_token.rb`:

        echo "Thredded::Application.config.secret_key_base = '$(bundle exec rake secret)'" > config/initializers/secret_token.rb
        echo "Thredded::Application.config.secret_token = '$(bundle exec rake secret)'" >> config/initializers/secret_token.rb

  ERROR
end
