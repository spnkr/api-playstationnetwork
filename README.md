# PlayStationNetwork::API

Retrieve User, Trophies and Game data from PlayStationNetwork.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'playstationnetwork-api', '~> 2.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install playstationnetwork-api

## Usage

#### Get a User
`PlayStationNetwork::User.new('pacMakaveli90').profile`

#### Get all Games for a User
`PlayStationNetwork::User.new('pacMakaveli90').games`


#### Get all Trophies for a Game
`PlayStationNetwork::User.new('pacMakaveli90').trophies('NPWR00132_00')`


#### Get a Game
`PlayStationNetwork::Game.new('NPWR00132_00').details`


#### Get all Trophies for a Game
`PlayStationNetwork::Game.new('NPWR00132_00').trophies`


#### Get all Games
`PlayStationNetwork::Game.new().all(platform: 'ps4') # you don't have to pass an argument. By default, it will get all games.`

#### Get Popular Games
`PlayStationNetwork::Game.new().all(popular: true)`

## Configuration

In your app, create a new initializer `playstationnetwork.rb` and add the following:

```
PlayStationNetwork::API.configure do |config|
  config.key = '<API_KEY>',
  config.secret = '<API_SECRET>'
  config.url = '<API_URL>'
})
```

Get Endpoint, your Key and Secret from: http://www.psnleaderboard.com/

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and add any changes to the `changelog`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/games-directory/api-playstationnetwork/. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

