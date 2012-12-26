# SpoonDaemon

A daemon tool for JRuby based on Spoon gem. 

Inspiration: https://gist.github.com/910177

## Installation

Add this line to your application's Gemfile:

    gem 'spoon_daemon'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spoon_daemon

## Usage

```ruby
# start daemon
SpoonDaemon.new('start', 'path/to/my/script.rb', 'tmp/pids')

# stop daemon
SpoonDaemon.new('stop', 'path/to/my/script.rb', 'tmp/pids')
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
