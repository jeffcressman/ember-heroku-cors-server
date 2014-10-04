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