Feature: add a new iteration
    As an instructor
    So that I can create a new course
    I want to open classes for students to enroll

 	Background: I am logged in as an instructor
 		Given I am logged in as Instructor

 	Scenario: I should be able to create course
 		Then I should see "Create Course" button

 	Scenario: Instructor can create course
        Given I press "Create Course"
        Then I should be on the new course page
        Then I should see "Create Course" button
        And I fill in "computer science 168" as "course_coursename"
        And I press "Create Course"
        Then I should be on the courses page
        And I should see "computer science 168"
        And I should see "Show Projects" link
