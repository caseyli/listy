# Listy

Listy is a Gem that contains a bunch of view helpers for use in Ruby on Rails to easily create different types of lists.

## Requirements

Listy is only compatible with Rails 3.1 and above.
It leverages both the Asset Pipeline and the JQuery library.

## Installation

Add this line to your application's Gemfile:

    gem 'listy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install listy

Listy also includes some Javascript assets, so be sure to add the following line to your application.js

	//= require listy

## Usage

There are a couple of helper methods including:

	listy_links(collection, display_method_name, css_class, show_more_index=5, empty_message="")

This method creates a simple unordered list of the elements in the collection.

	multi_column_listy_links(collection, display_method_name, css_class, number_of_columns)

This does the same thing as listy_links but presents it in the number of columns you specify.

	listy_tree(collection, spec, empty_message)

This method is for creating a nested tree of unordered lists for a collection with nested collections. This is suitable for Rails models that have has_many relationships.

Example let's say we have the following

* Country which has_many States
* State which has_many Cities

Typical usage would be:

	listy_tree(Country.all, {:display_method_name => :name, :children => :states, :child => { :display_method_name => :name, :children => :cities, :child => {:display_method_name => :name, :children => nil, :child => nil}}}, "")

Be sure that the inner most child of the spec has :children => nil. This will stop the nesting.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
