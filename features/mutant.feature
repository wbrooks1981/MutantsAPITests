Feature: Mutants
  As a user I want to work with the mutant api

  Scenario: Able to retrieve all mutants
    When I retrieve all mutants
    Then a list of mutants will be returned

  Scenario: Able to create a mutant
    When I create the mutant
    Then the mutant will be created

  Scenario: Able to retrieve a mutant
    Given I have a mutant
    When I retrieve the mutant
    Then the mutant will be returned

  Scenario: Able to update a mutant
    Given  I have a mutant
    And a name of "Piotr Rasputin"
    When I update the mutant
    Then the mutant will be updated

  Scenario: Able to delete a mutant
    Given  I have a mutant
    When I delete the mutant
    Then the mutant will be deleted

  Scenario: Verify response on missing alias
    Given I don't have a mutant name
    And I create the mutant
    Then the mutant will not be created
    And the error with "mutant_name" of "can't be blank"

  Scenario: Verify response on missing name
    Given I don't have a real name
    And I create the mutant
    Then the mutant will not be created
    And the error with "real_name" of "can't be blank"

  Scenario: Verify response on power
    Given I don't have an ability
    And I create the mutant
    Then the mutant will not be created
    And the error with "power" of "can't be blank"

  Scenario: Verify response on eligibility end date is before start date
    Given A mutant's eligibility starts "2016-03-15"
    And A mutant's eligibility ends "2016-02-15"
    When I create the mutant
    Then the mutant will not be created
    And the error with "eligibility_ends_at" of "is before the eligibility start date"