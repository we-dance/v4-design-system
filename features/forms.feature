Feature: Form Patterns
  As a developer
  I want to use standardized form patterns and validation
  So that I can create consistent and user-friendly forms

  Scenario: Creating a simple form with validation
    When I create a form with validation using vee-validate and zod
    Then the form should validate inputs according to the schema
    And display appropriate error messages for invalid inputs
    And only submit when all validations pass

  Scenario: Using different form layouts
    Given I need to create forms with different layouts
    When I use the standard layout
    Then fields should be stacked vertically with labels above inputs
    When I use the horizontal layout
    Then labels should be positioned beside inputs
    When I use the grid layout
    Then multiple fields should be arranged in columns
    When I use the compact layout
    Then fields should have reduced spacing and smaller text

  Scenario: Implementing different field types
    Given I need to collect different types of data
    When I use text inputs for single-line text
    And textarea inputs for multi-line text
    And select inputs for choosing from options
    And checkbox inputs for boolean values
    And radio inputs for mutually exclusive options
    And phone inputs for international phone numbers
    Then each field should be properly validated according to its type
    And provide appropriate user feedback

  Scenario: Handling form submission
    Given I have a valid form
    When I submit the form
    Then the form data should be processed
    And the user should receive confirmation
    When there are validation errors
    Then the form should not submit
    And error messages should be displayed
    And focus should be placed on the first invalid field

  Scenario: Implementing multi-step forms
    Given I have a complex form process
    When I break it into multiple steps
    Then users should see their progress
    And be able to navigate between steps
    And all validations should be maintained across steps
    And submission should only occur at the final step

  Scenario: Creating form arrays for dynamic data
    Given I need to collect variable amounts of data
    When I implement a form array pattern
    Then users should be able to add multiple items
    And remove existing items
    And each item should be validated individually
    And the entire collection should be submitted together 