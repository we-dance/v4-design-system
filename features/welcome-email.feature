Feature: Welcome Email
  As a platform administrator
  I want to send a welcome email to new users
  So that they feel welcomed and understand how to get started with the platform

  Scenario: View welcome email template
    Given I am logged in as an administrator
    When I navigate to the email templates section
    And I select the "Welcome Email" template
    Then I should see the welcome email template with customizable content

  Scenario: Preview welcome email
    Given I am viewing the welcome email template
    When I click the "Preview" button
    Then I should see a preview of how the email will appear to recipients

  Scenario: Customize welcome email content
    Given I am viewing the welcome email template
    When I update the email content
    And I save the changes
    Then the welcome email template should be updated with my changes

  Scenario: Send test welcome email
    Given I am viewing the welcome email template
    When I enter a test email address
    And I click the "Send Test" button
    Then a test welcome email should be sent to the specified address
    And I should see a confirmation message

  Scenario: New user receives welcome email automatically
    Given the welcome email is configured
    When a new user registers on the platform
    Then they should automatically receive the welcome email
    And the email should contain their registration information 