# languagecloud-sdl


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'languagecloud-sdl'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install languagecloud-sdl

## Usage

### Initialise 

````ruby
require 'languagecloud-sdl'

SDL =  LanguagecloudSdl::API.new(
            api_key: yourapikey,
            source_lang: source_lang
            )
````

Example.
Setting base language to eng

````ruby
require 'languagecloud-sdl'

SDL =  LanguagecloudSdl::API.new(
            api_key: 'SFGER439fvvds@#e2ds',
            source_lang: 'eng'
            )
````

### Usage

````ruby
SDL.translations('fra', {texts: ['title', 'short text', 'main text']})
````

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/howtwizer/languagecloud-sdl )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
