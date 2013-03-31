#!/usr/bin/env ruby

ENV['RAILS_ENV'] ||= 'production'

# Move into repo base to bundler can find Gemfile
basedir = ENV['$OPENSHIFT_REPO_DIR']

puts `cd #{basedir} && bundle exec ruby ./bin/clean_old.rb 2>&1`