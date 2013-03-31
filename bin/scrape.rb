require 'sendspot_scraper'

# Pull in Rails app.
require File.expand_path('../config/environment', File.dirname(__FILE__))

# These are the ids used by sendspot for the various ET locations.
locations_by_id = {
  1 => 'Columbia',
  2 => 'Timonium',
  3 => 'Rockville'
}

locations_by_id.each do |id, location|
  puts "Scanning for new routes in #{location}..."

  client = SendspotScraper::Client.new('earthtreks', id)

  scraper = SendspotScraper::Scraper.new(client)
  scraper.route_exists_hook = lambda do |rid|
    Route.find_by_rid(rid)
  end

  scraper.new_route_hook = lambda do |scraped|
    puts "#{scraped.name} #{scraped.grade}"

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
  end

  scraper.scrape_error_hook = lambda do |error|
    puts "Scrape error: #{error}"
  end

  scraper.scrape
end