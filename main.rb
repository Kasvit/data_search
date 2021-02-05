require './initializers/startup'

$database = Database.new('./data.json')
$database.populate_database

puts "Authors: #{$database.authors.size}"
puts "Languages: #{$database.languages.size}"
puts "Types: #{$database.types.size}"
puts "database loaded"

puts "example below"
puts "------"
r = Search.new($database).find(query: "microsoft")
puts r.map(&:to_s)
puts "------"

puts "Closing"
