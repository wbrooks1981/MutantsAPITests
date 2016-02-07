require "MutantsAPIGem"

Before do
  @mutant = MutantsAPIGem::Mutant.new({ :alias                  => "Cyclops",
                                        :name                   => "Scott Summers",
                                        :ability                => "Beams of energy from eyes",
                                        :eligibility_begin_date => Date.today,
                                        :eligibility_end_date   => Date.today + 30,
                                        :advise_begin_date      => Date.today - 1 })
end

When(/^I retrieve all mutants$/) do
  @response = MutantsAPIGem::Routes::Mutants.retrieve
end

Then(/^a list of mutants will be returned$/) do
  raise "List of mutants was not returned" unless @response.code == 200 && @response.is_a?(Array)
end

Given(/^an alias of "([^"]*)"$/) do |mutant_name|
  @mutant.alias = mutant_name
end

And(/^a name of "([^"]*)"$/) do |name|
  @mutant.name = name
end

And(/^an ability of "([^"]*)"$/) do |ability|
  @mutant.ability = ability
end

When(/^I create the mutant$/) do
  @response = @mutant.create
end

Then(/^the mutant will be created$/) do
  raise "Mutant wasn't created" if @mutant.id.nil?
end

Given(/^I have a mutant$/) do
  @mutant.create
  raise "Mutant wasn't created" if @mutant.id.nil?
end

When(/^I delete the mutant$/) do
  @response = @mutant.delete
end

Then(/^the mutant will be deleted$/) do
  raise "Mutant wasn't deleted" unless @mutant.id.nil?
end

Then(/^the mutant will be returned$/) do
  raise "Mutant wasn't returned" unless @mutant.id == @response["id"]
end

When(/^I retrieve the mutant$/) do
  @response = @mutant.retrieve
end

When(/^I update the mutant$/) do
  @mutant.update
end

Then(/^the mutant will be updated$/) do
  raise "Mutant wasn't updated" if @mutant.create_date == @mutant.modified_date
end

Given(/^I don't have a mutant name$/) do
  @mutant.alias = nil
end

Then(/^the mutant will not be created$/) do
  raise "Mutant was creating when it should have not been" if @response.code == 201
end

And(/^the error with "([^"]*)" of "([^"]*)"$/) do |field, error|
  validation = @response[field][0] == error
  raise "Validation error was not as expected" unless validation
end

Given(/^I don't have a real name$/) do
  @mutant.name = nil
end

Given(/^I don't have an ability$/) do
  @mutant.ability = nil
end

Given(/^A mutant's eligibility starts "([^"]*)"$/) do |start_date|
  @mutant.eligibility_begin_date = start_date
end

Given(/^A mutant's eligibility ends "([^"]*)"$/) do |end_date|
  @mutant.eligibility_end_date = end_date
end

Given(/^I have a mutant as an advisor/) do
  @mutant = MutantsAPIGem::Mutant.new({ :alias                  => "Professor X",
                                        :name                   => "Charles Xavier",
                                        :ability                => "Telepathy",
                                        :eligibility_begin_date => Date.today,
                                        :eligibility_end_date   => Date.today + 30,
                                        :advise_begin_date      => Date.today - 1 })
  @mutant.create
  raise "Mutant wasn't created" if @mutant.id.nil?
  @advisor = @mutant
end

And(/^I have a mutant as a student$/) do
  @mutant = MutantsAPIGem::Mutant.new({ :alias                  => "Cyclops",
                                        :name                   => "Scott Summers",
                                        :ability                => "Beams of energy from eyes",
                                        :eligibility_begin_date => Date.today,
                                        :eligibility_end_date   => Date.today + 30,
                                        :advise_begin_date      => Date.today - 1 })
  @mutant.create
  raise "Mutant wasn't created" if @mutant.id.nil?
  @student = @mutant
end


Given(/^I have a mutant who can advise in the future$/) do
  @mutant = MutantsAPIGem::Mutant.new({ :alias                  => "Professor X",
                                        :name                   => "Charles Xavier",
                                        :ability                => "Telepathy",
                                        :eligibility_begin_date => Date.today,
                                        :eligibility_end_date   => Date.today + 30,
                                        :advise_begin_date      => Date.today + 30 })
  @mutant.create
  raise "Mutant wasn't created" if @mutant.id.nil?
  @advisor= @mutant
end