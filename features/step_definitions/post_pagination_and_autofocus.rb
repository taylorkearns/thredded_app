Given /^posts are paginated every (\d+) posts$/ do |post_num|
  Thredded::Post.paginates_per post_num.to_i
end

Given /^the latest thread on "([^"]*)" has (\d+) posts$/ do |name, post_num|
  board = Thredded::Messageboard.where(name: name).first
  @topic = create(:topic, messageboard: board)

  create_list :post, post_num.to_i, topic: @topic, messageboard: board
end

Then /^the latest read post should not be set$/ do
  page.should have_css("section[data-latest-read='null']")
end

Then /^the latest read post should be the (first|fifth|sixth) post$/ do |post_index|
  posts = @topic.posts.order('id ASC')

  case post_index
  when 'first'
    post = posts.first
  when 'fifth'
    post = posts[4]
  when
    post = posts[5]
  end

  page.should have_css("section[data-latest-read='#{post.id}']")
  page.should have_css("article#post_#{post.id}")
end

When /^I click to page (\d+) and view the latest post$/ do |page_num|
  first('footer .pagination a', text: page_num).click
end

When /^(\d+) more people post on the latest thread$/ do |reply_num|
  create_list :post, reply_num.to_i,
    topic: @topic,
    messageboard: @topic.messageboard,
    user: User.first
end

Then /^I should see (\d+) posts$/ do |post_num|
  page.should have_css('article.post', count: post_num.to_i)
end

Then /^I should see page (\d+)$/ do |page_num|
  page.should have_css('.page.current', text: page_num)
end

When(/^I click the last updated topic$/) do
  first('article.topic:first h1 a').click
end
