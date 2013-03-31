# Load Rails env.
require File.expand_path('../config/environment', File.dirname(__FILE__))

count = 0

Route.old.each do |old_route|
  old_route.destroy
  count += 1
end

puts "Deleted #{count} old Routes"