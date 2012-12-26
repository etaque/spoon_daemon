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
SpoonDaemon::Runner.new('path/to/my/script.rb', cmd, options)
```

Where cmd is 'start', 'stop' or 'restart'

And options are:
 * `pid_dir`: where to create the PID file


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
