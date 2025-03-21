Feature: Course Editor
  As a dance teacher
  I want to create and manage my dance courses
  So that I can organize my teaching materials and sell my courses online

  Background:
    Given I am logged in as a teacher
    And I am on the teacher dashboard

  Scenario: Creating a new course
    When I click on "Create Course" button
    Then I should see the course editor interface
    And I should see the course details form

  Scenario: Filling in course details
    Given I am in the course editor
    When I fill in the following course details:
      | Field       | Value                |
      | Title       | Salsa Fundamentals   |
      | Description | Learn salsa basics   |
      | Difficulty  | Beginner             |
    And I click "Save" button
    Then the course details should be saved
    And I should see a success message

  Scenario: Adding a module to the course
    Given I am editing a course
    When I navigate to the "Course Structure" section
    And I click on "Add Module" button
    And I fill in the module title as "Introduction to Salsa"
    And I click "Save Module" button
    Then the module should be added to the course structure
    And I should see the module in the modules list

  Scenario: Adding a lesson to a module
    Given I am editing a course with a module "Introduction to Salsa"
    When I click on "Add Lesson" for that module
    And I fill in the following lesson details:
      | Field    | Value                 |
      | Title    | Basic Salsa Steps     |
      | Duration | 15                    |
    And I click "Save Lesson" button
    Then the lesson should be added to the module
    And I should see the lesson in the module's lessons list

  Scenario: Setting up course pricing
    Given I am editing a course
    When I navigate to the "Pricing" section
    And I set the monthly price to "29.99"
    And I select currency "USD"
    And I click "Save Pricing" button
    Then the pricing information should be saved
    And I should see a success message

  Scenario: Saving a draft course
    Given I am editing a course with complete details
    When I click "Save as Draft" button
    Then the course should be saved as a draft
    And I should be redirected to the teacher dashboard
    And I should see the course in my drafts list

  Scenario: Editing an existing course
    Given I have a draft course "Salsa Fundamentals"
    When I go to my drafts list
    And I click "Edit" on the "Salsa Fundamentals" course
    Then I should see the course editor with the course details loaded
    And I should be able to modify any section of the course

  Scenario: Cancelling course editing
    Given I am editing a course
    When I click "Cancel" button
    Then I should see a confirmation dialog
    When I confirm cancellation
    Then I should be redirected to the teacher dashboard
    And changes should not be saved

  Scenario: Validation errors on course save
    Given I am editing a course with incomplete details
    When I click "Save" button
    Then I should see validation error messages
    And I should remain in the course editor
    And the errors should be highlighted on the form 