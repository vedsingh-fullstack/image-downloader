# frozen_string_literal: true

require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task :environment do
  # load environment-specific dependencies here
end

task default: %i[spec rubocop]

Dir.glob("lib/tasks/**/*.rake").each { |r| load r }
