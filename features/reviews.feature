Feature: Profile Reviews
  As a user
  I want to leave a review for an artist, organizer, or venue
  So that others can benefit from my feedback

  Background:
    Given I am a logged in user
    And I have attended an event

  Scenario: User leaves a review for an organizer
    When I navigate to the organizer's profile page
    And I click on "Write a Review" button
    Then I should see a review form
    When I select a star rating
    And I enter a review text
    And I submit the review
    Then I should see my review on the organizer's profile
    And I should see a success notification

  Scenario: User edits their review
    Given I have previously left a review
    When I navigate to the profile page with my review
    And I click on the "Edit" button on my review
    Then I should see the review form with my previous input
    When I modify the rating or text
    And I save the changes
    Then I should see my updated review
    And I should see a success notification

  Scenario: User deletes their review
    Given I have previously left a review
    When I navigate to the profile page with my review
    And I click on the "Delete" button on my review
    Then I should see a confirmation dialog
    When I confirm the deletion
    Then my review should be removed
    And I should see a success notification 