Feature: Enrollment
  As a user I want to work with the enrollment api

  Scenario: Able to Enroll in a term
    And I have a term
    And I have a mutant
    When I enroll the mutant in the term
    Then the enrollment will be created

  Scenario: Able to retrieve all enrollments for a mutant
    Given I have mutant enrolled in a term
    When I retrieve all the enrollments for the mutant
    Then the enrollments will be returned

  Scenario: Able to retrieve a specific enrollment for a mutant
    Given I have mutant enrolled in a term
    When I retrieve the enrollment for the mutant
    Then the enrollment will be returned

  Scenario: Verify response on enrolling in a term already started
    Given A term already started
    And I have a term
    And I have a mutant
    When I enroll the mutant in the term
    Then the enrollment will not be created
    And the error with "student" of "is not eligible for that term"

  Scenario: Verify response on enrolling in a term already ended
    Given A term already ended
    And I have a term
    And I have a mutant
    When I enroll the mutant in the term
    Then the enrollment will not be created
    And the error with "student" of "is not eligible for that term"

  Scenario: Able to add mutant to term
    And I have a term
    And I have a mutant
    When I add a mutant to the term
    Then the enrollment will be created

  Scenario: Able to retrieve all enrollments for a term
    Given I have term with an enrolled mutant
    When I retrieve all the enrollments for the term
    Then the enrollments will be returned

  Scenario: Able to retrieve a specific enrollment for a term
    Given I have term with an enrolled mutant
    When I retrieve the enrollment for the term
    Then the enrollment will be returned

  Scenario: Verify response on adding mutant to term already started
    Given A term already started
    And I have a term
    And I have a mutant
    When I add a mutant to the term
    Then the enrollment will not be created
    And the error with "student" of "is not eligible for that term"

  Scenario: Verify response on adding mutant to a term already ended
    Given A term already ended
    And I have a term
    And I have a mutant
    When I add a mutant to the term
    Then the enrollment will not be created
    And the error with "student" of "is not eligible for that term"