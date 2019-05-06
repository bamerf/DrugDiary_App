require 'pry'
require_relative 'db_config'

# lets tell the translation about our tables
require_relative 'models/log'
require_relative 'models/user'
require_relative 'models/like'

binding.pry