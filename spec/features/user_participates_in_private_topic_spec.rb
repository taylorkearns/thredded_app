require 'spec_helper'

feature 'Private topics' do

  scenario 'can be viewed by me' do
    setup_defaults
    joel = log_me_in
    john = other_user
    private_topic = private_topic_between(joel, john)

    private_topic.create

    expect(private_topic).to be_listed
    expect(private_topic).to be_readable
    expect(private_topic).to have(1).posts
  end

  scenario 'between others cannot be viewed by me' do
    joel = log_me_in
    john = other_user('john')
    sal  = other_user('sal')
    private_topic = private_topic_without_me(sal, john)

    private_topic.load_index

    expect(private_topic).not_to be_listed

    private_topic.load_topic

    expect(private_topic).not_to be_readable
  end

  def setup_defaults
    create(:app_config)
    messageboard
  end

  def messageboard
    @messageboard ||= create(:messageboard)
  end

  def log_me_in
    @log_me_in ||= begin
      me = PageObject::User.new.log_in
      me.join(messageboard)
      me
    end
  end

  def other_user(name='john')
    @other_user ||= begin
      other_user = PageObject::User.new.user(name, "#{name}@example.com")
      other_user.join(messageboard)
      other_user
    end
  end

  def private_topic_between(user_one, user_two)
    PageObject::PrivateTopic.new(
      user_one: user_one,
      user_two: user_two,
      messageboard: messageboard,
      title: 'Ermagerdness',
    )
  end
end
