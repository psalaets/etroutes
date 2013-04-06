require 'sendspot_scraper'

# Pull in Rails app.
require File.expand_path('../config/environment', File.dirname(__FILE__))

# These are the ids used by sendspot for the various ET locations.
location_ids = [
  1, # Columbia
  2, # Timonium
  3  # Rockville
]

client = SendspotScraper::Client.new(location_ids)

puts "Scanning for new routes..."

scraper = SendspotScraper::Scraper.new(client)
scraper.route_hook = lambda do |scraped|
  puts "route_hook running... (#{scraped.name})"

  route = Route.find_by_rid(scraped.id)

  if route.nil?
    puts "New: #{scraped.name} #{scraped.grade} in #{scraped.location}"

    r = Route.new
    r.rid       = scraped.id
    r.url       = scraped.url
    r.name      = scraped.name
    r.grade     = scraped.grade
    r.types     = scraped.types
    r.gym       = scraped.gym
    r.location  = scraped.location
    r.set_by    = scraped.set_by
    r.save

    true
  else
    false
  end
end

scraper.scrape_error_hook = lambda do |error|
  puts "Scrape error: #{error}"
end

scraper.scrape