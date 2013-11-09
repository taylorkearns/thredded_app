Thredded.user_class = 'User'
Thredded.email_incoming_host = 'incoming.thredded.com'
Thredded.email_from = 'no-reply@thredded.com'
Thredded.email_outgoing_prefix = '[Thredded Mail-Bot] '
Thredded.user_path = ->(user){ "/users/#{user}" }

if Rails.env.production? || Rails.env.staging?
  Thredded.file_storage = :fog
else
  Thredded.file_storage = :file
end
