[![Gem](https://img.shields.io/gem/v/gstatsat.svg?style=flat)](http://rubygems.org/gems/omniauth-memair)
[![License](http://img.shields.io/badge/license-MIT-yellow.svg?style=flat)](https://github.com/memair/omniauth-memair/blob/master/LICENSE)
[![Gregology](https://img.shields.io/badge/contact-Gregology-blue.svg?style=flat)](http://gregology.net/contact/)
[![Downloads](https://img.shields.io/gem/dt/gstatsat.svg?style=flat)](http://rubygems.org/gems/omniauth-memair)

# Omniauth-memair

Memair OAuth2 Strategy for OmniAuth.

Read the Memair API documentation for more details: https://docs.memair.com/#authenticationcreate_an_app

## Installing

Add to your `Gemfile`:

```ruby
gem 'omniauth-memair'
```

Then `bundle install`.

## Usage

`OmniAuth::Strategies::Memair` is simply a Rack middleware. Read the OmniAuth docs for detailed instructions: https://github.com/intridea/omniauth.

Ensure your Memair app has the `user_details` scope. Then add the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :memair, ENV['MEMAIR_CLIENT_ID'], ENV['MEMAIR_CLIENT_SECRET']
end
```

You can pass multiple scopes. For example to read and write a user's biometric data set the scope to `biometric_read biometric_write`

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :memair, ENV['MEMAIR_CLIENT_ID'], ENV['MEMAIR_CLIENT_SECRET'], scope: 'biometric_read biometric_write'
end
```
