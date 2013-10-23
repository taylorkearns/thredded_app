Devise.setup do |config|
  require 'devise/orm/active_record'

  config.mailer_sender = 'no-reply@thredded.com' # or your own address
  config.authentication_keys = [:email]
  config.case_insensitive_keys = [:email]
  config.stretches = 10
  config.pepper = "9975f15b00a842d3c1b9528561a1cb5c7c7a0b826faff8039f5364c587afcc5e0b6a2152c613bd960ab3d4ac16ed255ec857a24d2a8905d7084b60fd969632c2"
  config.email_regexp = /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i
end
