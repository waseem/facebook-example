Given /^"([^\"]*)" is a facebook connected user$/ do |user|
  setup_fb_connect_cookies(user)
end

When /^"([^\"]*)" connects with awesome application$/ do |user|
  post('/session')

  if response.code == '200'
    #
  else
    fail_facebook
  end
end

Then /^"([^\"]*)" should see "([^\"]*)"$/ do |user, message|
  Then "I should see \"#{message}\""
end
