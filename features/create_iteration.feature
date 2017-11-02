Feature: add a new iteration
    As an instructor
    So that I can create a new, empty, iteration task list
    I want to add an iteration and specify it's name 

    Background: I am on the instructor-dashboard page
        Given I am logged in as Instructor with "cs169"
        And I follow "Show Projects"

    Scenario: no iteration initially
        Then I should see message "You have not created an interation for this course yet!"

    Scenario: create a new iteration
        Then I should see "Create Iteration" link
        Given I follow "Create Iteration"
        Then I should be on the new iteration page
        Then I should see "Create Iteration" button
        And I fill in "phase 1" as "iteration_name"
        And I press "Create Iteration"
        Then I should be on the instructor dashboard page
        And I should see "phase 1" link

    Scenario: view an iteration I've created
        Given I have "phase 1" iteration created under "cs169"
        And I am on the courses page
        And I follow "Show Projects"
        And I should see "phase 1" link
        And I follow "phase 1"
        Then I should see "Iteration: phase 1"
        And I should see "Iteration Template for phase 1"
        And I should see "Edit Iteration" link
        And I should see "Delete Iteration" link
        And I should see "Publish Iteration" link

    Scenario: I can edit an existing iteration
        Given I have "phase 1" iteration created under "cs169"
        And I am on the courses page
        And I follow "Show Projects"
        And I follow "phase 1"
        And I follow "Edit Iteration"
        And I fill in "first iteration" as "iteration_name"
        And I press "Save Iteration"
        Then I should be on the instructor dashboard page
        And I should not see "phase 1"
        And I should see "first iteration"

    Scenario: I should be able to delete an iteration
        Given I have "phase 1" iteration created under "cs169"
        And I am on the courses page
        And I follow "Show Projects"
        And I follow "phase 1"
        And I follow "Delete Iteration"
        Then I should be on the instructor dashboard page
        And I should not see "phase 1"
        And I should see message "You have not created an interation for this course yet!"

    Scenario: Iterations should be ordered by most recent first by default
        Given I have "phase 1" iteration created under "cs169"
        And I have "accelerating iter" iteration created under "cs169"
        And I am on the courses page
        And I follow "Show Projects"
        Then I should see "phase 1" before "accelerating iter"

    Scenario: I can release an iteration
        Given I have "phase 1" iteration created under "cs169"
        And I am on the courses page
        And I follow "Show Projects"
        And I follow "phase 1"
        And I follow "Publish Iteration"
        And I should see message "Successfully published iteration!"
        And I should see "Iteration Template for phase 1"
        And I should see "Edit Iteration" link
        And I should see "Delete Iteration" link
        And I should see "Publish Iteration" link

    Scenario: I can add a start date, end date, and title to an iteration
        Given I have "phase 1" iteration created under "cs169"
        And I am on the courses page
        And I follow "Show Projects"
        And I follow "phase 1"
        And I follow "Edit Iteration"
        And I fill in "phase 1" as "iteration_name"
        And I fill in "start" date with "10/15/2017"
        And I fill in "end" date with "10/22/2017"
        And I press "Save Iteration"
        And I follow "phase 1"
        Then I should see "From 2017-10-15 To 2017-10-22"

 