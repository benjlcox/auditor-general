# AuditorGeneral

Simple and explicit user action auditing for Rails

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'auditor-general'
```

Then execute:

    $ bundle

Or install it yourself as:

    $ gem install auditor-general

Then run the following command:

```
rails g auditor_general:install
```

## Usage

Add the following to `ApplicationController` (or only to relevant controllers):

```ruby
include AuditorGeneral::Controller
```
This will ensure `curent_user.email` is logged with each action. If `current_user` is unavailable the controller name will be logged instead

And then the following to all models that will be audited:

```ruby
include AuditorGeneral::Model
```

You can indicate which attributes to monitor with the following syntax:

```ruby
  auditable attributes: [:name]
```

And you can optionally turn off auditing create/destroy by including:

```ruby
  auditable attributes: [:name], create: false, destroy: false
```

You can log arbitrary actions not tied to models with this syntax:

```ruby
  AuditorGeneral.log(model_type: "SomeLibrary", action: "restart", message: "Restarting some library somewhere")
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/auditor-general/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
