Given /^"([^"]*)" threads already exist on "([^"]*)"$/ do |thread_count, board|
  messageboard = Thredded::Messageboard.find_by_name(board)
  user = User.first
  thread_count.to_i.times do
    topic = create(:topic, messageboard: messageboard, user: user, last_user: user)
    post = create(:post, topic: topic, user: user)
  end
end

Given /^I have read them all$/ do
  user = User.first
  Thredded::Topic.all.each do |topic|
    create(:user_topic_read, topic_id: topic.id, user_id: user.id,
      post_id: topic.posts.last.id, posts_count: topic.posts.count)
  end
end

When /^someone responds to the oldest topic$/ do
  create(:post, topic: Thredded::Topic.last, user: User.last)
end

Then /^the first topic should be unread$/ do
  page.should have_selector('#topics_listing article:nth-child(1).topic.unread')
end

Then /^the second topic should be read$/ do
  page.should have_selector('#topics_listing article:nth-child(2).topic.read')
end
