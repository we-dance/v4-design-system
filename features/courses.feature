Feature: Courses Page
  As a user
  I want to visit the courses page
  So that I can see available courses

  Scenario: Visit courses page
    When I visit the courses page
    Then I should see the list of dance courses

  Scenario: User journey Yarima class
    When I visit the courses page
    And I click on "Salsa Ladies Styling" course
    Then I should be redirected to the course details page
    When I click on "View Pricing Plans" button
    Then I should see a dialog with title "Choose Your Plan"
    When I click on "Regular Plan" button

  Scenario: Course Editor
    Given I am logged in as a teacher
    When I click on "Create Course" button
    Then I should see the course editor component
    When I fill in the course details
      | Field             | Value                           |
      | Course Name       | Bachata Sensual Fundamentals    |
      | Description       | Learn the basics of Bachata Sensual |
      | Level             | Beginner                        |
    And I add a module named "Introduction to Bachata Sensual"
    And I add a lesson to the module with title "Basic Steps" and duration "15 minutes"
    And I set the pricing plan to "€19.99" per month
    When I click on "Save" button
    Then I should see a success message
    And the course should be saved to my draft courses
