Given(/^I am under "([^"]*)"$/) do |page|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see a link to "([^"]*)"$/) do |web|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I redirect to iteration page for "([^"]*)" and "([^"]*)"$/) do |itername, classname|
	iter = Iteration.where(name: itername).first
	cla = Course.where(coursename: classname).first
	params[course_id: cla.id]
	print "hahahahah"
	print "/iterations/#{iter.id}?course_id=#{cla.id}"
	visit "/iterations/#{iter.id}?course_id=#{cla.id}"
end

Then(/^Task "(.*)" is parent for Task "(.*)"$/) do |parent, child|
	parent_task = Task.where(title: parent)
	child_task = Task.where(title: child)
	child_task.parents.length == 1
end

Then(/^I goto courses page$/) do
	visit path_to("the courses page")
end

Then(/^I should see "([^"]*)" under "([^"]*)"$/) do |content, tag|
  pending # Write code here that turns the phrase above into concrete actions
end


Given(/^I check "([^"]*)" as parents$/) do |parent_task|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I select "([^"]*)" and press edit$/) do |task|
  pending # Write code here that turns the phrase above into concrete actions
end

Given (/^I create Task "([^"]*)" to "([^"]*)"$/) do |title, description|
  pending
end

And (/^I  am on Iteration "([^"]*)"$/) do |iter|
  pending
end