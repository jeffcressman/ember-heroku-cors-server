source 'https://rubygems.org'

gem 'rails', '4.1.5'

gem 'rails-api'

gem 'spring', :group => :development

group :development, :test do
  gem 'sqlite3'
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
end

group :production do
  gem 'pg'
  gem 'rails_12factor' # required by Heroku
  gem 'unicorn'
end

gem 'rack-cors', :require => 'rack/cors'

gem 'active_model_serializers', '~>0.8.2'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
