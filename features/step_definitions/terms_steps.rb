require "MutantsAPIGem"

Before do
  @term = MutantsAPIGem::Term.new({:start_date => Date.today + 5,
                                   :end_date   => Date.today + 90})
end

When(/^I retrieve all terms$/) do
  @response = MutantsAPIGem::Routes::Terms.retrieve
end

Then(/^a list of terms will be returned$/) do
  raise "List of terms was not returned" unless @response.code == 200 && @response.is_a?(Array)
end

Given(/^A term starts "([^"]*)"$/) do |start_date|
  @term.start_date = Date.parse(start_date)
end

And(/^A term ends "([^"]*)"$/) do |end_date|
  @term.end_date = Date.parse(end_date)
end

When(/^I create the term$/) do
  @response = @term.create
end

Then(/^the term will be created$/) do
  raise "Term wasn't created" if @term.id.nil?
end

Given(/^I have a term$/) do
  @term.create
  raise "Term wasn't created" if @term.id.nil?
end

When(/^I retrieve the term$/) do
  @response = @term.retrieve
end

Then(/^the term will be returned$/) do
  raise "Term wasn't returned" unless @term.id == @response["id"]
end

When(/^I update the term$/) do
  @term.update
end

Then(/^the term will be updated$/) do
  raise "Term wasn't updated" if @term.create_date == @term.modified_date
end

When(/^I delete the term$/) do
  @term.delete
end

Then(/^the term will be deleted$/) do
  raise "Mutant wasn't deleted" unless @term.id.nil?
end

Given(/^I don't have a term start date$/) do
  @term.start_date = nil
end

Then(/^the term will not be created$/) do
  raise "Term was created when it should have not been" unless @term.id.nil?
end

Given(/^I don't have a term end date$/) do
  @term.end_date = nil
end

When(/^I add a mutant to the term$/) do
  @enrollment = @term.enroll(@mutant)
  @response = MutantsAPIGem::Routes::Terms.response if @enrollment.id.nil?
end

Given(/^A term already started$/) do
  @term.start_date = Date.today - 1
end

Given(/^A term already ended$/) do
  @term.start_date = Date.today - 10
  @term.end_date = Date.today - 5
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
  @enrollment = @term.enroll(@mutant)
end