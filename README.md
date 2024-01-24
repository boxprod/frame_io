# FrameIo
Very basic (and wip) Frame.io API wrapper
Only OAuth2 authentification available at the moment.



## Installation
Add this line to your application's Gemfile:

```ruby
gem "frame_io"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install frame_io
```


## Usage
This gem uses and bundles [omniauth-frameio](https://github.com/boxprod/omniauth-frameio)

# Omniauth configuration:

This Strategy is meant to be used with [Omniauth](https://github.com/omniauth/omniauth) and has been tested and used with [Devise](https://github.com/heartcombo/devise#omniauth)

If using Devise, add this in your Devise.setup in /config/initializers/devise.rb

```ruby
config.omniauth   :frameio,
                  ENV['FRAME_CLIENT_ID'], # Your app client ID (on Frame.io Oauth app mgmt)
                  ENV['FRAME_CLIENT_SECRET'], # Your app client Secret (on Frame.io Oauth app mgmt)
                  scope: 'offline' # list of availables scopes to find on Frame.io dev doc
```

Please follow Omniauth & Devise instructions for complete configuration.

# Wrapper configuration:

```ruby
class User < ApplicationRecord
  act_as_frameio_user
end
```

By default, frame_io wrapper is expecting the model to respond_to? :access_token, :refresh_token and :expires_at

If you want to change the column names:

```ruby
class User < ApplicationRecord
  act_as_frameio_user access_token: :some_column, refresh_token: :some_other_column, expires_at: :oh_so_other_column
end
```

That's all! You now have access to a frame.io client:

```ruby
current_user.frame_io #=> FrameIo::Client

current_user.frame_io.accounts #=> All accounts for user frame.io account
```

Due to the nature of the 'tree' on Frame.io, objects needs to be retrieved in chain

```ruby
current_user.accounts.first.teams.first.projects.first.assets.first.children
```

Each step is cahced by default. If you need to refresh, you can pass:
```ruby
cache: false
```
at any moment, like that:

```ruby
current_user.frame_io.accounts.first.teams.first.projects(cache: false).first.assets
```

It will refresh from projects and downward.


Lastly, all objects are findable by ID without the need of the 'chain', like that:

```ruby
current_user.frame_io.asset(id: 'some_id')
```

It obviously works if an only current_user has access to the file in Frame.io


## Contributing
Please raise issues at will, and suggest better ways to handle this!

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
