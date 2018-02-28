#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:core) do |spec|
  spec.rspec_opts = ['--backtrace']
end

task :default => [:core]

Bundler::GemHelper.install_tasks
