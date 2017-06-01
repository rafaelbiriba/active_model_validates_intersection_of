# Active Model Validates Intersection Of

A custom validation for your Active Model that check if an array is included in another one.

Identical to the method `validates_inclusion_of` from ActiveModel but for array comparison.

Consider an User model that have some set of "default" permissions.

```ruby
class User < ActiveRecord::Base
  DEFAULT_PERMISSION = ["read", "write", "share"]
  validates_intersection_of :permission, in: DEFAULT_ROLES
end
```

If you want to validate your user based on an array:

```ruby
 user = User.new(permission:["read", "admin"])
 user.valid? #false
```

 This active model custom validation **is for you**!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_model_validates_intersection_of'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_model_validates_intersection_of

## Usage

* `in:` parameter is required
* `message:` is optional

```ruby
class User < ActiveRecord::Base
  DEFAULT_PERMISSION = ["read", "write", "share"]
  validates_intersection_of :permission, in: DEFAULT_ROLES
end
```

```ruby
class User < ActiveRecord::Base
  DEFAULT_PERMISSION = ["read", "write", "share"]
  validates_intersection_of :permission, in: DEFAULT_ROLES, message: "invalid permission"
end
```

You can also use the custom validation directly:

```ruby
class User < ActiveRecord::Base
  DEFAULT_PERMISSION = ["read", "write", "share"]
  validates_with ActiveModelValidatesIntersectionOf::Validator, attributes: [:permission], in: VALID_ARRAY
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Contributing

First of all, **thank you** for wanting to help!

1. [Fork it](https://help.github.com/articles/fork-a-repo).
2. Create a feature branch - `git checkout -b more_magic`
3. Add tests and make your changes
4. Check if tests are ok - `rake spec`
5. Commit changes - `git commit -am "Added more magic"`
6. Push to Github - `git push origin more_magic`
7. Send a [pull request](https://help.github.com/articles/using-pull-requests)! :heart:
