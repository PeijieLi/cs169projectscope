Feature: Students and Instructors can add comments to tasks, general metrics and iterations
  
  As a student or instructor,
  So that I can add information regarding tasks, general metrics and iterations,
  I want to be able to add comments in any of these locations
  
  Given the following projects exist:
  | name      |
  | Project_1 |
  | Project_2 |

  Given the following iterations exist:
  | iteration_name | project   |
  | iteration_01   | Project_1 |
  | iteration_11   | Project_1 |
  | iteration_02   | Project_2 |
  | iteration_12   | Project_2 |

  Given the following tasks exist:
  | title    | iteration_id | task_id |
  | first_1  | iteration_01 | first_1 |
  | second_1 | iteration_01 | first_1 |
  | first_2  | iteration_02 | first_2 |
  | second_2 | iteration_02 | first_2 |

  Given the following users exist:
  | provider_username       | uid         | email                 | provider  | role    | project   |
  | Admin                   | uadmin      | uadmin@example.com    | developer | admin   | Project_1 |
  | Student                 | ustudent    | ustudent@example.com  | developer | student | Project_1 |
  | Student2                | ustudent2   | ustudent2@example.com | developer | student | Project_2 |
  
@wip
Scenario: add admin comment to a task
  Given I am "uadmin" and logged in
  And I am on the "iteration_01" page
  Then I should see "Project_1"
  And I follow "Project_1"
  Then I should see "first_1"
  And I follow "first_1"
  Then I should see "add_comment"
  And I fill in "content" with "this is an admin comment on a task"
  And I press "Submit"
  Then I should see "this is an admin comment on a task"
  
@wip
Scenario: add student commment to a task
  Given I am "ustudent" and logged in
  And I am on the "Project_1, iteration_01" page
  Then I should see "first_1"
  And I follow "first_1"
  Then I should see "add_comment"
  And I fill in "content" with "this is a student comment on a task"
  And I press "Submit"
  Then I should see "this is a student comment on a task"
  
@wip
Scenario: add admin comment to iteration
  Given I am "uadmin" and logged in
  And I am on the "iteration_01" page
  Then I should see "Project_1"
  Then I should see "add_comment"
  And I fill in "content" with "this is an admin comment on iteration_01"
  And I press "Submit"
  Then I should see "this is an admin comment on iteration_01"
  
@wip
Scenario: add student comment to iteration
  Given I am "ustudent" and logged in
  And I am on the "Project_1, iteration_01" page
  Then I should see "add_comment"
  And I fill in "content" with "this is a student comment on an iteration"
  And I press "Submit"
  Then I should see "this is a student comment on an iteration"
  
@wip
Scenario: add admin comment to a general metric
  Given I am "uadmin" and logged in
  And I am on the "view project 'Project_1'" page
  And I follow "Code Climate"
  Then I should see "Submit"
  And I fill in the"general" comment box with "this is an admin comment on a general metric"
  And I press "Submit"
  Then I should see "this is an admin comment on a general metric"
  
@wip
Scenario: add student commment to a general metric
  Given I am "ustudent" and logged in
  And I am on the "view project 'Project_1'" page
  And I follow "Code Climate"
  Then I should see "Submit"
  And I fill in the "general" comment box with "this is a student comment on a general metric"
  And I press "Submit"
  Then I should see "this is a student comment on a general metric"

  