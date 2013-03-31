#!/usr/bin/env ruby

# Every 10 minutes
if Time.now.min.to_s[-1] == '0'
  puts `bundle exec ruby ENV['$OPENSHIFT_REPO_DIR']/bin/scrape.rb 2>&1`
end