Given /^I am logged in and visiting a "(.*)" messageboard$/ do |security|
  Given %{a "#{security}" messageboard exists named "thredded"}
  And %{I am signed up and confirmed as "user@domain.com/omglol"}
  And %{I sign in as "user@domain.com/omglol"}
end

Given /^I am a member of "(.*)"$/ do |name|
  user = User.last
  Thredded::Messageboard.where(name: name).first.add_member user
end

Given /^I am not a member of "(.*)"$/ do |name|
  user = User.last
  user.thredded_roles.delete_all
  user.reload
end

Given /^I am an anonymous visitor$/ do
  create(:user)
  user = User.new
end

Given /^I am an admin for "([^"]*)"$/ do |name|
  messageboard = Thredded::Messageboard.where(name: name).first
  messageboard.add_member @current_user, 'admin'
end
