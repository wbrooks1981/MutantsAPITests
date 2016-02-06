# Hooks can be used to prepare and clean the environment before and after each scenario is executed.
# The hooks included in your base project are needed for logging and reporting
# You can create your own before/after/fail/pass hooks as needed
# https://github.com/cucumber/cucumber/wiki/Hooks

After do
  @mutant.delete if @mutant && @mutant.id != nil
  @term.delete if @term && @term.id != nil
end
