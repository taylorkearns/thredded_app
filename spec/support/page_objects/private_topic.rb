module PageObject
  class PrivateTopic
    include Capybara::DSL
    include PageObject::Authentication
    include Rails.application.routes.url_helpers
    include FactoryGirl::Syntax::Methods

    def initialize(options={})
      @me = options[:user_one] || create(:user)
      @them = options[:user_two] || create(:user)
      @messageboard = options[:messageboard] || create(:messageboard)
      @title = options[:title] || 'Secret topic'
      @content = options[:content] || 'Hello'
    end

    def create
      visit messageboard_topics_path(@messageboard)
      find('.new_private_topic a').click
      fill_in 'topic_title', with: @title
      select @them.name, from: 'topic_user_id'
      fill_in 'topic_posts_attributes_0_content', with: @content
      find('.submit input').click
    end

    def listed?
      visit messageboard_private_topics_path(@messageboard)
      has_content?(@title)
    end

    def readable?
      visit messageboard_private_topics_path(@messageboard)
      click_on(@title)
      has_content?(@content)
    end

    def posts
      topic = Topic.where(title: @title).first
      visit messageboard_topic_posts_path(@messageboard, topic)
      all('article.post')
    end
  end
end
