require 'data_mapper'

env = ENV['RACK_ENV'] || 'test'

# we are telling the datamapper to use a postgres database on localhost.
# The name will be 'boommark_manager_test' or 'bookmark_manager_development'
#depending on the environment

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './app/models/link.rb' # require each model individaully - the path may vary
require './app/models/tag.rb'# depending on your file structure

#After declaring your models, you should finalise them
DataMapper.finalize

# However, the databse tables don't exist yet. Let's tell datamapper to create them
DataMapper.auto_upgrade!
