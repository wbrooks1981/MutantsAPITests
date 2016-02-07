Feature: Advisor
  As a user I want to work with the enrollment api

  Scenario: Add an Advisor to mutant
    Given I have a mutant as an advisor
    And I have a mutant as a student
    When I create the advisor relationship
    Then the the mutant is an advisor

  Scenario: Get all Advisess of a mutant
    Given I have a student with an advisor
    When I retrieve all the students of the advisor
    Then the students will be returned

  Scenario: Delete an Advisee from a mutant
    Given I have a student with an advisor
    When I remove the student from the advisor
    Then the mutant will not be the advisor

    #defect
  Scenario: Verify error when making an advisor before they can
    Given I have a mutant who can advise in the future
    And I have a mutant as a student
    When I create the advisor relationship
    Then the the mutant will not be an advisor
    And the error with "ends_at" of "can't be before begins at"

  Scenario: Verify error when deleting a relationship that doesn't exist
    Given I have a mutant as a student
    And I have a mutant as an advisor
    When I remove the student from the advisor
    Then the removing of student from advisor will fail due to not existing