# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application

require 'rack/cors'
use Rack::Cors do

  # Allow all origins. Handle access with authentication.
  allow do
    origins '*'
    resource '*', 
        :headers => :any, 
        :methods => [:get, :post, :delete, :put, :options]
  end
end