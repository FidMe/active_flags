# ActiveFlags
Active Flags allows you to use automatic flags on models. You won't have to create useless booleans with view logic in your core tables. They should not have been there in the first place, let Active Flags handle them for you!

## Installation

(You need at least rails 5.0 to use the gem)
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
To do so you would add a boolean `active` or `visible` in your user's table.

It works, but it is view logic and shouldn't be there. Imagine your app is growing and you have 10 more booleans on your user table, and then 10 more on another model. It will only pollute your tables.

Once Active Flags is set, you can easily declare that your model has flags like that:

```ruby
class User < ApplicationRecord
  has_flags :visible, :active
end
```

And that's it!
You can now add flags on a user like that:

```ruby
user.flags = { visible: 'true', active: 'true' }
user.save!
```

A flag won't be saved if you don't explicitly declare it as has_flags attributes in the model.

But if you do not want to handle explicit flags, you could also declare:

```ruby
class User < ApplicationRecord
  has_flags
end
```

And then you can declare as much flags as you want with no restriction:
```ruby
user.update!(flags: { visible: 'true', active: 'true', diet: 'vegan', power: 'super saiyan' })
```

To access your flags, you now have 2 ways.
Either as a hash, with the `flags` method or as an ActiveFlag::Flags collection with the `flags_as_collection` method.

## Contributing
https://github.com/FidMe/active_flags

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).