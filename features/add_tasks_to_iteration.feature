Feature: add and edit tasks to exisiting iteration

    As an instructor
    I want to add tasks to an iteration and order the tasks
    So that students will know what they need to do in the iteration.
  
    Background: I am on the instructor-dashboard page
        Given I am logged in as Instructor with "cs169"
        And I have "phase 1" iteration created under "cs169"
        And I am on the courses page
        And I follow "Show Projects"
        And I follow "phase 1"

    Scenario: Instructor should see a link to add task
        Then I should see "Add new task" link

    Scenario: Instructor could add a task to interation
        When I follow "Add new task"
        And I fill in "task 1-1" as "task_title"
        And I fill in "collect user stories" as "task_description"
        And I press "Create Task"
        Then I should be on iteration page for "phase 1"
        And I should see message "Successfully created task"
        And I should see "task 1-1"
        And I should see "edit" link
        And I should see "delete" link

    Scenario: task creation must specify task description
        When I follow "Add new task"
        And I fill in "task 1-1" as "task_title"
        And I press "Create Task"
        Then I should be on iteration page for "phase 1"
        And I should see message "Please fill in all required fields"
        And I should not see "task 1-1"
        And I should not see "edit" link
        And I should not see "delete" link

    Scenario: task creation must specify task title
        When I follow "Add new task"
        And I fill in "collect user stories" as "task_description"
        And I press "Create Task"
        Then I should be on iteration page for "phase 1"
        And I should see message "Please fill in all required fields"
        And I should not see "task 1-1"
        And I should not see "edit" link
        And I should not see "delete" link

    Scenario: edit existing task
        Given I follow "Add new task"
        And I fill in "task 1-1" as "task_title"
        And I fill in "collect user stories" as "task_description"
        And I press "Create Task"
        When I should be on iteration page for "phase 1"
        And I follow "edit"
        Then I should be on edit task page for "task 1-1"
        And I fill in "first task" as "task_title"
        And I press "Save Task"
        Then I should be on iteration page for "phase 1"
        And I should not see "task 1-1"
        And I should see "first task"

    Scenario: add more task for a iteration
        Given I follow "Add new task"
        And I fill in "task 1-1" as "task_title"
        And I fill in "collect user stories" as "task_description"
        And I press "Create Task"
        Then I follow "Add new task"
        And I fill in "task 1-2" as "task_title"
        And I fill in "write features" as "task_description"
        And I press "Create Task"
        Then I should be on iteration page for "phase 1"
        And I should see "task 1-1" before "task 1-2"
        And I should see "collect user stories" before "write features"

    Scenario: delete existing task
        Given I follow "Add new task"
        And I fill in "task 1-1" as "task_title"
        And I fill in "collect user stories" as "task_description"
        And I press "Create Task"
        When I should be on iteration page for "phase 1"
        And I follow "delete"
        Then I should be on iteration page for "phase 1"
        And I should not see "task 1-1"
        And I should not see "edit" link
        And I should not see "delete" link

    Scenario: create task with parent
        Given I follow "Add new task"
        And I fill in "111" as "task_title"
        And I fill in "collect user stories" as "task_description"
        And I press "Create Task"
        Then I should be on iteration page for "phase 1"
        Then I follow "Add new task"
        And I fill in "222" as "task_title"
        And I fill in "write features" as "task_description"
        And I check "tasks[111]"
        And I press "Create Task"
        Then I should be on iteration page for "phase 1"
        And I should see "111"
        And I should see "222"
        And Task "111" is parent for Task "222"

