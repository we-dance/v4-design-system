Feature: Input Component
  As a user interface designer
  I want to use consistent input fields across the application
  So that users can enter data in a familiar and accessible way

  Scenario: View input variants
    Given I am viewing the input documentation
    When I look at the variants section
    Then I should see default, disabled, and error state variants
    And each variant should have a visual example and description

  Scenario: View input types
    Given I am viewing the input documentation
    When I look at the input types section
    Then I should see text, email, password, number, and search types
    And each type should have appropriate validation and behavior

  Scenario: Use input with label and description
    Given I am implementing a form input
    When I add a label and description
    Then the label should be properly associated with the input
    And the description should provide additional context

  Scenario: Use input with validation
    Given I am implementing a form with validation
    When I add validation rules to an input
    Then error messages should be displayed when validation fails
    And the input should show an error state

  Scenario: Use input with prefix/suffix
    Given I am implementing an input with additional content
    When I add prefix or suffix elements
    Then they should be properly aligned with the input
    And the input should maintain its proper spacing 