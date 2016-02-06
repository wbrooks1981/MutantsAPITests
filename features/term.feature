Feature: Terms
  As a user I want to work with the terms api

  Scenario: Able to retrieve all terms
    When I retrieve all terms
    Then a list of terms will be returned

  Scenario: Able to create a term
    When I create the term
    Then the term will be created

  Scenario: Able to retrieve a term
    Given I have a term
    When I retrieve the term
    Then the term will be returned

  Scenario: Able to update a term
    Given  I have a term
    And A term ends "2016-06-04"
    When I update the term
    Then the term will be updated

  Scenario: Able to delete a term
    Given  I have a term
    When I delete the term
    Then the term will be deleted

  Scenario: Verify response on missing term start date
    Given I don't have a term start date
    And I create the term
    Then the term will not be created
    And the error with "begins_at" of "can't be blank"

  Scenario: Verify response on missing term end date
    Given I don't have a term end date
    And I create the term
    Then the term will not be created
    And the error with "ends_at" of "can't be blank"
        #defect
  Scenario: Verify response on term end date before start
    Given A term starts "2016-03-15"
    And A term ends "2016-02-10"
    And I create the term
    Then the term will not be created
    And the error with "ends_at" of "can't be before begins at"

