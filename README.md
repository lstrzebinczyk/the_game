#The Game

Disclaimer: I know nothing about developing games, nor do I know what I am doing in this code. Most of the code is a mess, where I only expect a nice structure to emerge at some point.

I would be more than happy to discuss code structure or architecture.

## Guard

    guard

watches .rb files and .coffee files and recompiles them automatically

## Running it

1. bundle install
2. rake build
3. rake build_coffee
4. ruby app.rb

Sadly we have to use Sinatra app, since chrome refuses to load images from disk.

And it should work.

## Contributing

1. Fork it ( https://github.com/KillaPL/the_game )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
