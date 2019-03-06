# ActiveFlags
Active Flags allows you to use automatic flags on models. You won't have to create useless booleans with view logic in your core tables. There place shouldn't have been there in the first place, let Active Flags handle them for you!

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'active_flags'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install active_flags
```

Then import Active Flags' migrations
```bash
$ bin/rails active_flags:install:migrations
```

Adapt them if needed and run db:migrate
```bash
$ rails db:migrate
```

## Usage
Let's say you're building a networking app, with users connecting each other.
But you want it to be so relevant that it only makes active users (connecting often enough) visibles on the search.
To do so you would add a boolean `active` or `visible` in your users' table.
It works, but it is view logic and shouldn't be there. Imagine your app is growing and you have 10 more boolean on users, and then 10 more on another model. It will only pollute your tables.

Once Active Flags is set, you can easily declare your model as flaggable like that:
```ruby
class User < ApplicationRecord
    act_as_flaggable
end
```

And that's all!
You can now add flags on a user with two possibilities.

Either set the key-value as keys and content as values:

```ruby
user.flags = [
  { key: 'visible', value: 'true'},
  { key: 'active', value: 'true'}
]
```

Or pass directly the pair key_name: content

```ruby
user.flags = [
  { visible: 'true'},
  { active: 'true'}
]
```

## Contributing
https://github.com/FidMe/active_flags

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).