Then(/^I should see "([^"]*)" link$/) do |link|
	page.should have_link(link)
end

Then(/^I should not see "([^"]*)" link$/) do |link|
	page.should_not have_link(link)
end

Then(/^I should see "([^"]*)" button$/) do |link|
	page.should have_button(link)
end

Given(/^I have "([^"]*)" iterations created$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see "([^"]*)" iterations$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I fill in "(.+)" as "(.+)"$/) do |data, field|
	fill_in(field, :with => data)
end


Then(/^I should see message "([^"]*)"$/) do |arg|
	page.should have_content(arg)
end

Then(/^I should see text "([^"]*)"$/) do |arg|
	page.should have_content(arg)
end

Given(/^I have "(.+)" iteration created under "(.+)"$/) do |iter_name, classname|
	course = Course.where(coursename: classname).first
	iter = Iteration.create!(name: iter_name, course_id: course.id, start: Time.now.to_date, end: Time.now.to_date + 7.days, release_at: Time.now)
end

Then /^I fill in "(.*)" date with "(.*)"/ do |name, value|
  months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  vals = value.split("/")

  select vals[2], :from => 'iteration_' + name + '_1i'
  select months[(vals[0].to_i - 1)], :from => 'iteration_' + name + '_2i'
  select vals[1], :from => 'iteration_' + name + '_3i'
  
end
