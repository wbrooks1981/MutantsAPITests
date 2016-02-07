When(/^I create the advisor relationship$/) do
  @response = @advisor.advise(@student)
end

Then(/^the the mutant is an advisor/) do
  raise "Mutant didn't become advisor" unless @student.id == @response["id"] && @advisor.id == @response["advisor"]["id"]
end

Given(/^I have a student with an advisor$/) do
  @mutant = MutantsAPIGem::Mutant.new({ :alias                  => "Cyclops",
                                        :name                   => "Scott Summers",
                                        :ability                => "Beams of energy from eyes",
                                        :eligibility_begin_date => Date.today,
                                        :eligibility_end_date   => Date.today + 30,
                                        :advise_begin_date      => Date.today - 1 })
  @mutant.create
  raise "Mutant wasn't created" if @mutant.id.nil?
  @student = @mutant
  @mutant = MutantsAPIGem::Mutant.new({ :alias                  => "Professor X",
                                        :name                   => "Charles Xavier",
                                        :ability                => "Telepathy",
                                        :eligibility_begin_date => Date.today,
                                        :eligibility_end_date   => Date.today + 30,
                                        :advise_begin_date      => Date.today - 1 })
  @mutant.create
  raise "Mutant wasn't created" if @mutant.id.nil?
  @advisor= @mutant
  @response = @advisor.advise(@student)
end

When(/^I retrieve all the students of the advisor$/) do
  @response = @advisor.advisees
end

Then(/^the students will be returned$/) do
  raise "Students were not returned" unless @response.code == 200 && @response.is_a?(Array)
end

When(/^I remove the student from the advisor$/) do
  @response = @advisor.remove_advisee(@student)
end

Then(/^the mutant will not be the advisor$/) do
  raise "Student was not removed from Advisor" unless @response.code == 200 && @response["advisor"].nil?
end

Then(/^the the mutant will not be an advisor$/) do
  raise "Mutant became an advisor when it shouldn't" if @response.code == 201
end

Then(/^the removing of student from advisor will fail due to not existing$/) do
  raise "Removal error was not as expected" unless @response.code == 404
end