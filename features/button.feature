Feature: Button Component
  As a user interface designer
  I want to use consistent button styles across the application
  So that users can easily identify and interact with actionable elements

  Scenario: View button variants
    Given I am viewing the button documentation
    When I look at the variants section
    Then I should see primary, secondary, outline, ghost, link, and destructive variants
    And each variant should have a visual example and description

  Scenario: View button sizes
    Given I am viewing the button documentation
    When I look at the sizes section
    Then I should see default, small, large, and icon size options
    And each size should have a visual example and description

  Scenario: Use button with icon
    Given I am implementing a button with an icon
    When I add an icon component inside the button
    Then the icon should be properly aligned with the text
    And the button should maintain its proper spacing

  Scenario: Use loading state button
    Given I am implementing a loading state button
    When I set the button to loading state
    Then the button should show a loading spinner
    And the button should be disabled during loading

  Scenario: Use icon-only button
    Given I am implementing an icon-only button
    When I use the icon size variant
    Then the button should be square
    And the icon should be centered in the button 