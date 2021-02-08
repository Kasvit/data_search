require 'pry'
require 'json'
require 'securerandom'

Dir['./lib/errors/*.rb'].each{ |f| require f }
Dir['./lib/*.rb'].each{ |f| require f }
Dir['./models/*.rb'].each{ |f| require f }
