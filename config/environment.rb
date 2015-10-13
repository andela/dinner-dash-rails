# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActiveRecord::Base.logger.level = Logger::DEBUG
