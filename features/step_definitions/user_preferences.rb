When /^I enable the '@ notification' preference$/ do
  check "Notify me when I am @'ed"
  click_button 'Update Preferences'
end

Then /^I should be notified when someone mentions me$/ do
  user = User.last
  create(:post,
    content: "hi @#{user.name}",
    messageboard: user.thredded_messageboards.first,
    topic: create(:topic, messageboard: user.thredded_messageboards.first)
  )

  steps %Q{
    When "joel@email.com" opens the email
    Then they should see "@#{user.name}" in the email body
    And they should see "mentioned you in" in the email body
  }
end
