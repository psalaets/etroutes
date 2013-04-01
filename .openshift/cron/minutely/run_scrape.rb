#!/usr/bin/env ruby

ENV['RAILS_ENV'] ||= 'production'

# Every 20 minutes
if [0, 20, 40].include? Time.now.min
  # Move into repo base so bundler can find Gemfile
  basedir = ENV['OPENSHIFT_REPO_DIR']
  puts `cd #{basedir} && bundle exec ruby ./bin/scrape.rb 2>&1`
end