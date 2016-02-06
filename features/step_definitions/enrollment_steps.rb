require "MutantsAPIGem"

Then(/^the enrollments will be returned$/) do
  raise "List of mutants was not returned" unless @response.code == 200 && @response.is_a?(Array)
end

Then(/^the enrollment will be created$/) do
  raise "Mutant didn't get enrolled into term" if @enrollment.id.nil?
end

Then(/^the enrollment will be returned$/) do
  raise "Enrollment wasn't returned" unless @enrollment.id == @response["id"]
end

Then(/^the enrollment will not be created$/) do
  raise "Enrollment was created when it should have not been" if @response.code == 201
end