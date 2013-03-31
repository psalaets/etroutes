#!/usr/bin/env ruby

puts `bundle exec ruby ENV['$OPENSHIFT_REPO_DIR']/bin/clean_old.rb 2>&1`