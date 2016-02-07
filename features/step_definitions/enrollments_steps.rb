require "MutantsAPIGem"

Then(/^the enrollments will be returned$/) do
  raise "List of mutants was not returned" unless @response.code == 200 && @response.is_a?(Array)
end

Then(/^the enrollment will be created$/) do
  raise "Mutant didn't get enrolled into term" if @enrollment.id.nil?
end

Then(/^the enrollment will be returned$/) do
  raise "Enrollment wasn't returned" unless @response.code == 200
end

Then(/^the enrollment will not be created$/) do
  raise "Enrollment was created when it should have not been" if @response.code == 201
end

When(/^I enroll the mutant in the term$/) do
  @response = @mutant.enroll(@term)
  @enrollment = @mutant.enrolls.last if @response.code == 201
end

Given(/^I have mutant enrolled in a term$/) do
  @term.create
  @mutant.create
  @response = @mutant.enroll(@term)
  @enrollment = @mutant.enrolls.last if @response.code == 201
end

When(/^I enroll the mutant$/) do
  @mutant.enroll(@term)
end

When(/^I retrieve all the enrollments for the mutant$/) do
  @response = @mutant.enrollments
end

When(/^I retrieve the enrollment for the mutant$/) do
  @response = @mutant.enrollments(@enrollment)
end

When(/^I add a mutant to the term$/) do
  @response = @term.enroll(@mutant)
  @enrollment = @term.enrolls.last if @response.code == 201
end

When(/^I retrieve all the enrollments for the term$/) do
  @response = @term.enrollments
end

When(/^I retrieve the enrollment for the term$/) do
  @response = @term.enrollments(@enrollment)
end

Given(/^I have term with an enrolled mutant$/) do
  @term.create
  @mutant.create
  @response = @term.enroll(@mutant)
  @enrollment = @term.enrolls.last if @response.code == 201
end