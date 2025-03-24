Feature: Header with Language Selection
  As a user
  I want to be able to switch between different languages
  So that I can view the content in my preferred language

  Background:
    Given I am on any page of the website
    And the header is visible at the top of the page

  Scenario: Viewing the language selector
    Then I should see a language selector in the header
    And it should display the current language
    And it should show a dropdown with available languages

  Scenario: Changing the language
    When I click on the language selector
    Then I should see a dropdown menu with available languages
    When I select a different language
    Then the website content should update to the selected language
    And the language selector should display the newly selected language

  Scenario: Persisting language preference
    When I select a different language
    Then my language preference should be saved
    And when I return to the website later
    Then the website should load in my last selected language 