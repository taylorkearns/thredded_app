include ActionDispatch::TestProcess

FactoryGirl.define do
  sequence(:user_email) { |n| "user#{n}@example.com" }
  sequence(:user_name) { |n| "user#{n}" }
  sequence(:other_email) { |n| "other#{n}@email.com" }
  sequence(:other_name) { |n| "other#{n}" }
  sequence(:password) { |n| "password#{n}" }
  sequence(:topic_hash) { |n| "hash#{n}" }


  factory :email, class: OpenStruct do
    to 'email-token'
    from 'user@email.com'
    subject 'email subject'
    body 'Hello!'
    attachments {[]}

    trait :with_attachment do
      attachments {[
        ActionDispatch::Http::UploadedFile.new({
          filename: 'img.png',
          type: 'image/png',
          tempfile: File.new("#{File.expand_path File.dirname(__FILE__)}/samples/img.png")
        })
      ]}
    end

    trait :with_attachments do
      attachments {[
        ActionDispatch::Http::UploadedFile.new({
          filename: 'img.png',
          type: 'image/png',
          tempfile: File.new("#{File.expand_path File.dirname(__FILE__)}/samples/img.png")
        }),
        ActionDispatch::Http::UploadedFile.new({
          filename: 'zip.png',
          type: 'image/png',
          tempfile: File.new("#{File.expand_path File.dirname(__FILE__)}/samples/zip.png")
        })
      ]}
    end
  end

  factory :identity do
    uid '1'
    provider 'github'
  end

  factory :messageboard, class: Thredded::Messageboard do
    sequence(:name) { |n| "messageboard#{n}" }
    sequence(:title) { |n| "Messageboard #{n}" }
    description 'This is a description of the messageboard'
    security 'public'
    posting_permission  'anonymous'

    trait :logged_in do
      security 'logged_in'
    end

    trait :private do
      security 'private'
    end

    trait :public do
      security 'public'
    end

    trait :restricted_to_logged_in do
      security 'logged_in'
    end

    trait :postable_for_logged_in do
      posting_permission 'logged_in'
    end
  end

  factory :post, class: Thredded::Post do
    user
    topic
    messageboard

    sequence(:content) { |n| "A post about the number #{n}" }
    ip '127.0.0.1'
    filter 'bbcode'
  end

  factory :post_notification

  factory :post_with_no_associations, class: 'Post' do
    sequence(:content) { |n| "A post about the number #{n}" }
    ip '127.0.0.1'
    filter 'bbcode'
  end

  factory :app_config do
    permission           'public'
    title                'Default website'
    description          'default website description'
    email_from           'Site <email@email.com>'
    email_subject_prefix '[Email] '
    incoming_email_host  'reply.email.com'
  end

  factory :user do
    email { FactoryGirl.generate(:user_email) }
    name  { FactoryGirl.generate(:user_name) }
    current_sign_in_at 10.minutes.ago
    last_sign_in_at    10.minutes.ago
    current_sign_in_ip '192.168.1.1'
    last_sign_in_ip    '192.168.1.1'
    superadmin         'f'
    time_zone          'Eastern Time (US & Canada)'
    password

    factory :email_confirmed_user do
      email              { FactoryGirl.generate(:user_email) }
      name               { FactoryGirl.generate(:user_name) }
    end

    factory :last_user do
      email              { FactoryGirl.generate(:other_email) }
      name               { FactoryGirl.generate(:other_name) }
    end

    trait :superadmin do
      superadmin 't'
    end
  end

  factory :user_topic_read do
    user_id 1
    topic_id 1
    post_id 1
    page 1
  end
end
