# Listy

Listy is a Gem that contains a bunch of view helpers for use in Ruby on Rails to easily create different types of lists.

## Installation

Add this line to your application's Gemfile:

    gem 'listy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install listy

## Usage

There are a couple of helper method including:

### list_of_links(collection, display_method_name, css_class, show_more_index=5, empty_message="")

This method creates a simple unordered list of the elements in the collection.

### multi_column_list_of_links(collection, display_method_name, css_class, number_of_columns)

This does the same thing as list_of_links but presents it in the number of columns you specify.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
