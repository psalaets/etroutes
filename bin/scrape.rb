require 'sendspot_scraper'

# These are the ids used by sendspot for the various ET locations.
locations_by_id = {
  1 => :columbia,
  2 => :timonium,
  3 => :rockville
}

locations_by_id.each do |id, location|
  client = SendspotScraper::Client.new('earthtreks', id)

  scraper = SendspotScraper::Scraper.new(client)
  scraper.route_exists_hook = lambda do |rid|
    puts "doing route exists check for rid: #{rid}"
    false
  end

  scraper.new_route_hook = lambda do |route|
    puts "New route: |#{route.name}| |#{route.grade}| at #{route.location}"
  end

  scraper.scrape
end