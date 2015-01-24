# Nightlight

Shed light on the dark corners of your app

Nightlight is an admin tool that helps teams keep a fresh eye on all parts of their app, especially those parts that are commonly overlooked (until it's a big problem).

[Demo available here](http://nightlight-demo.herokuapp.com/nightlight)

![Screenshot](https://cloud.githubusercontent.com/assets/227274/5839169/ca4585fe-a1cf-11e4-8491-39ab7a6f1948.png)

Inspired by [Cap Watkins](https://twitter.com/cap)' [The Dark Corners of Your UI](http://blog.capwatkins.com/dark-corners)


## Features

- Maintain a list of parts/pages/UI in your app ("pages" for simplicity). Easily sync with `GET` routes in your `config/routes.rb`, or manage the list manually as you need.
- Indicate when you've checked/tested a page, with an optional status update (all good? any bugs? link to Trello card?)
- See which pages haven't been checked/tested in a while (I'm looking at you, password reset page)
- Assign pages to yourself to check, and see what other team members are checking
- Click a button to get a random page that nobody else is checking

## Benefits

- Keep fresh eyes on pages/UI your team doesn't see very often (onboarding, edge cases)
- Discover things your automated tests aren't catching (CSS bugs, typos, bad impressions, forgot-to-update-that-too's)
- Discover things that user feedback isn't catching
- Improve product quality and internal product awareness (try: everyone on the team checks a random page every day)
- A way to share useful page/UI-level meta info across the team (useful notes, gotchyas, how-to's, please-don't's)

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

## Credit

Inspired by:
- [Cap Watkins](https://twitter.com/cap)' [The Dark Corners of Your UI](http://blog.capwatkins.com/dark-corners)
- [@ankane](https://github.com/ankane)'s [ankane/blazer](https://github.com/ankane/blazer)

## Contributing

1. Fork it ( https://github.com/bonsaiben/nightlight/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
