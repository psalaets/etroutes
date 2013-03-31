#!/usr/bin/env ruby

ENV['RAILS_ENV'] ||= 'production'

# Move into repo base to bundler can find Gemfile
basedir = ENV['OPENSHIFT_REPO_DIR']

# Every 30 minutes
if [0, 30].include? Time.now.min
  puts `cd #{basedir} && bundle exec ruby ./bin/scrape.rb 2>&1`
end