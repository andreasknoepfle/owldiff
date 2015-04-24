# Owldiff

[![Build Status](https://travis-ci.org/andreasknoepfle/owldiff.svg)](https://travis-ci.org/andreasknoepfle/owldiff) [![Code Climate](https://codeclimate.com/github/andreasknoepfle/owldiff/badges/gpa.svg)](https://codeclimate.com/github/andreasknoepfle/owldiff) [![Test Coverage](https://codeclimate.com/github/andreasknoepfle/owldiff/badges/coverage.svg)](https://codeclimate.com/github/andreasknoepfle/owldiff)

This is the client library for the http://github.com/andreasknoepfle/owldiff-service server.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'owldiff'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install owldiff

## Usage

```ruby
    client = Owldiff::Client.setup "localhost", 4567
    client.query "http://test.de/a.owl", "http://test.de/b.owl"
```
or
```ruby
    Owldiff::Client.setup "localhost", 4567
    Owldiff::Client.diff "http://test.de/a.owl", "http://test.de/b.owl"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Tests

    $ rake test

## Contributing

1. Fork it ( https://github.com/[my-github-username]/owldiff/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
