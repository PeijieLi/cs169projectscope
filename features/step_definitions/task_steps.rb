Given(/^I am under "([^"]*)"$/) do |page|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see a link to "([^"]*)"$/) do |web|
  steps %Q{ I should see the "#{web}" link}
   # Write code here that turns the phrase above into concrete actions
end

Then(/^I should be redirect to dashboard page$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see "([^"]*)" under "([^"]*)"$/) do |content, tag|
  pending # Write code here that turns the phrase above into concrete actions
end


Given(/^I check "([^"]*)" as parents$/) do |parent_task|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I select "([^"]*)" and press edit$/) do |task|
  steps %Q{ 
    Given I follow "#{task}"
    # Then I press "Edit"
  }
  # pending # Write code here that turns the phrase above into concrete actions
end

Given (/^I create Task "([^"]*)" to "([^"]*)"$/) do |title, description|
  iter = Iteration.find_by_name("iteration_1")
  t1 = Task.new
  t1.iteration=iter
  t1.title=title
  t1.description=description
  t1.save
  # pending
end
Given("I go back to iteration dashboard") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I select {string} to copy") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given("Create team {string}") do |string|
  n = Project.new
  n.name= string
  n.save
   # Write code here that turns the phrase above into concrete actions
end

Then("I should see graph for {string}") do |string|
   steps %Q{Then I should see the "#{string}" link}
   # Write code here that turns the phrase above into concrete actions
end



Then("I edit {string}") do |string|
   steps %Q{Then I follow "#{string}"
   }
  # Write code here that turns the phrase above into concrete actions
end

Given("I am logged in as {string}") do |string|
   admin_user = User.create!(provider_username: "Admin_stu", uid: "uadmin_stu", email: 'uadmin_stu@example.com',
                            provider: "developer", role: User::STUDENT, password: Devise.friendly_token[0,20])
  ENV['ADMIN_PASSWORD'] = 'password'
  puts "log in"
  puts admin_user.role
  admin_user.project_id = Project.find_by_name(string).id
  admin_user.save
  visit "/login/#{admin_user.uid}?passwd=password"
   # Write code here that turns the phrase above into concrete actions
end

Given("I select {string}") do |string|
  steps %Q{ I follow "#{string}"}
  # pending # Write code here that turns the phrase above into concrete actions
  
end

# And (/^I  am on Iteration "([^"]*)"$/) do |iter|
#   steps %Q{
#     And I have "iteration_1, iteration_2" iterations created
#     And I am on the "iteration dashboard" page
#     Then I should see the "iteration_1" link
#     When I follow "iteration_1"
#   }
# end