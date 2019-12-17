# See https://relishapp.com/rspec/rspec-core/docs/command-line/rake-task
# See also https://rubydoc.info/github/rspec/rspec-core/RSpec/Core/RakeTask#rspec_opts-instance_method
begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = "ruby/spec/*"
  end
  task :default => :spec
rescue LoadError
  # no rspec available
end
