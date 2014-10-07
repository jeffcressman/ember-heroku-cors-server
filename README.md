Ember Heroku Cors Server
========================

This is the API server for [this](https://github.com/jeffcressman/ember-heroku-cors-client) Ember frontend.

See the frontend README for project details.

## How This Application Was Built

```bash
rvm gemset create ember-heroku-cors-server
rvm gemset use ember-heroku-cors-server
echo "ruby-2.1.2" >> .ruby-version
echo "ember-heroku-cors-server" >> .ruby-gemset
gem install rails-api
rails-api new ember-heroku-cors-server --skip-sprockets --database=postgresql
```

Add gems we'll be using:

```ruby
gem 'thin'

group :development, :test do
  gem 'sqlite3'
  gem "better_errors"
  gem "binding_of_caller"
end

group :production do
  gem 'pg'
  gem 'rails_12factor' # required by Heroku
end

gem 'rack-cors', :require => 'rack/cors'

gem 'active_model_serializers', '~>0.8.2'
```

```bash
bundle
```

Set up a simple User model

```bash
rake db:create
rails-api g model User name:string email:string password:string type:string
rails-api g serializer User
rake db:migrate
rake db:seed
```

## Adding CORS Support

Add [rack-cors](https://github.com/cyu/rack-cors) to Gemfile.

```ruby
gem 'rack-cors', :require => 'rack/cors'
```

Configure rack-cors in `config/application.rb`

```ruby
    config.middleware.insert_before "ActionDispatch::Static", "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
```

Restart rails server. All is well.

Adjust origins so we can only access from `http://localhost:4200/`, `127.0.0.1:4200` and `http://ember-heroku-cors-client.heroku.com`.

```ruby
    config.middleware.insert_before "ActionDispatch::Static", "Rack::Cors" do
      allow do
        origins 'http://localhost:4200/', '127.0.0.1:4200', 'http://ember-heroku-cors-client.heroku.com'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
```

## Set Up Heroku

Add `rails_12factor` gem to `Gemfile`.

```ruby
gem 'rails_12factor', group: :production
```

```bash
bundle
```

In file config/database.yml remove:
```ruby
production:
  <<: *default
  database: ember-heroku-cors-server_production
  username: ember-heroku-cors-server
  password: <%= ENV['EMBER-HEROKU-CORS-SERVER_DATABASE_PASSWORD'] %>
```

```bash
heroku create ember-heroku-cors-server
git push heroku master
heroku run rake db:migrate
heroku run rake db:seed
```

## Notes

We can check what headers are being returned using CURL, i.e. `$ curl -I -H 'Origin: *' -X GET http://ember-heroku-cors-server.herokuapp.com/users`

The Ember Wknd demo [client](https://github.com/jeffcressman/ember-wknd) and [server](https://github.com/jeffcressman/ember-wknd-server) work with the rack-cors configuration in `config/application.rb` but in this app it only works if we put the configuration in `config.ru`.