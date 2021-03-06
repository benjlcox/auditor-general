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

Then run the following command to create the necessary migration:

```
rails g auditor_general:install
```

Then do a normal Rails migration:

```
rake db:migrate
```

## Usage

Add the following to `ApplicationController` (or only to relevant controllers):

```ruby
include AuditorGeneral::Controller
```
This will ensure `curent_user.email` is logged with each action. If `current_user` is unavailable the controller name will be logged instead

Then add the following to all models that will be audited:

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

## Web View

Auditor General includes an optional web view for log files with some simple filtering features built in. To access this dashboard simply add the following to your `routes.rb` file:

```ruby
  mount AuditorGeneral::Web => '/auditor-general'
```

Importantly, this will create a public route to view the dashboard. You an restrict the route to, for example, a certain user role using a [constraint.](http://guides.rubyonrails.org/routing.html#request-based-constraints)

## Contributing

1. Fork it ( https://github.com/Shopify/auditor-general/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
