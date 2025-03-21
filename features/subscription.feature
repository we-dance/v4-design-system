Feature: Subscription Management
  As a registered user
  I want to upgrade or downgrade my subscription plan
  So that I can access different feature sets based on my needs

  Background:
    Given I am logged in as a registered user
    And I am on the settings page

  Scenario: View available subscription plans
    When I navigate to the "Subscription" settings tab
    Then I should see my current subscription plan highlighted
    And I should see all available subscription plans with prices and features

  Scenario: Upgrade subscription plan
    Given I have a "Basic" subscription plan
    When I navigate to the "Subscription" settings tab
    And I select the "Pro" subscription plan
    Then I should see a summary of the changes to my subscription
    And I should see that the new price will take effect immediately
    When I click "Confirm Upgrade"
    Then I should see a success notification "Subscription upgraded"
    And my subscription should be updated to "Pro"
    And I should be charged the new subscription amount

  Scenario: Downgrade subscription plan
    Given I have a "Pro" subscription plan
    When I navigate to the "Subscription" settings tab
    And I select the "Basic" subscription plan
    Then I should see a summary of the changes to my subscription
    And I should see that the new plan will take effect at the end of the current billing cycle
    When I click "Confirm Downgrade"
    Then I should see a success notification "Subscription downgraded"
    And I should see my current plan is still "Pro" until the end of the billing cycle
    And I should see my plan will change to "Basic" on the next billing date 