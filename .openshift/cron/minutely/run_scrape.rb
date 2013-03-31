#!/usr/bin/env ruby

ENV['RAILS_ENV'] ||= 'production'

# Move into repo base to bundler can find Gemfile
basedir = ENV['OPENSHIFT_REPO_DIR']

# Every 3 minutes
if %w(3 6 9).include? Time.now.min.to_s[-1]
  puts `cd #{basedir} && bundle exec ruby ./bin/scrape.rb 2>&1`
end