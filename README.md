# Nightlight

Shed light on the dark corners of your app

Nightlight helps you make sure all pages in your app are getting the love and attention they deserve

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nightlight'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nightlight

Run the install generator:

```sh
rails g nightlight:install
rake db:migrate
```

And mount the dashboard in your `config/routes.rb`:

```ruby
mount Nightlight::Engine, at: "nightlight"
```

## Authentication

Don’t forget to protect the dashboard in production.

### Basic Authentication

Set the following variables in your environment or an initializer.

```ruby
ENV["NIGHTLIGHT_USERNAME"] = "ben"
ENV["NIGHTLIGHT_PASSWORD"] = "secret"
```

### Devise

```ruby
authenticate :user, lambda{|user| user.admin? } do
  mount Nightlight::Engine, at: "nightlight"
end
```

## Contributing

1. Fork it ( https://github.com/bonsaiben/nightlight/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
