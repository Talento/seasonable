# Seasonable

Seasonable add to your models a visibility dates, thanks to this gem you can get your models are visible only within some specified date range.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'seasonable', git: 'git@github.com:the-cocktail/seasonable.git'
```

And then execute:

```shell
$ bundle
```

Install migrations

```shell
rake seasonable_engine:install:migrations
```

Review the generated migrations then migrate
```shell
rake db:migrate
```

## Usage

Include el module Seasonable in your model:

```ruby
class ModelName < ActiveRecord::Base
  include Seasonable::ActsAsSeasonable
  ...
end
```

Now you can save the values `starts_at` and `ends_at` in your model for indicate its visibility period. Remember add this values through `season_constrains` relation using `accepts_nested_attributes_for` Rails system.

```erb
<% seasons = seasonable.season_constrains.empty? ? Seasonable::SeasonConstrain.new : seasonable.season_constrains %>
<%= form.fields_for :season_constrains, seasons do |f| %>
  <%= f.date_field :starts_at %>
  <%= f.date_field :ends_at %>
<% end %>
```

Then you can use the scope `ModelName.visible_today` for get all data visibles today. You can use the instance method `#visible_today?` for detect if a instance is visible today.