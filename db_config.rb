require 'pg'
require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'druglog_app'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)