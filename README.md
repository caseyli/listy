# Listy

Listy is a Gem that contains a bunch of view helpers for use in Ruby on Rails to easily create different types of lists.

I apologize for all the updates happening in 0.0.X. This started out as a test gem project with very bad code, and I'm refactoring and updating the code pretty frequently.
I will do my best to keep this document up to date with the versions.

## Requirements

Listy is only compatible with Rails 3.1 and above.
It leverages both the Asset Pipeline and the JQuery library.

So either manually include your own version of JQuery, or ensure the bundled version is specified in your `app/assets/javascripts/application.js`

```ruby
	//= require jquery
	//= require jquery_ujs
```

If you don't plan on using any of the Hiding/Collapsing of the lists - you don't have to include the JQuery stuff.

## Installation

Add this line to your application's Gemfile:

    gem 'listy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install listy

Listy also includes some Javascript assets, so be sure to add the following line to your application.js

	//= require listy

If you don't plan on using any of the Hiding/Collapsing of the lists - you don't have to include this.

## Usage

There are a couple of helper methods including:

### listy_links

	listy_links(collection, display_method_name, options={})

This method creates a simple unordered list of the elements in the collection. This is suitable for Ruby on Rails models.

Options you can pass in include

* :css_class - The class that is applied to the resulting ul list element
* :empty_message - The message that is displayed if the collection is empty
* :show_more - If set to true, the list will display only the first 10 elements, and hide the rest and create a "Show More" link. Show more functionality requires JQuery and list.js - please read above.
* :show_more_limit - If you want more that the first 10 elements to show when show_more is set to true, then specify that limit here.

Examples

```ruby
	<%= listy_links BlogPost.all, :title %>
	
	<%= listy_links User.all, :email, :show_more => true %>
	
	<%= listy_links Product.all, :part_number, :show_more => true, :show_more_limit => 100, :css_class => "products-list" %>
```
### multi_column_listy_links

	multi_column_listy_links(collection, display_method_name, number_of_columns, options={})

This does the same thing as listy_links but presents it in the number of columns you specify.

Options you can pass in include:

* :css_class - The class that is applied to the resulting ul list elements in each column
* :empty_message - The message that is displayed if the collection is empty

Examples

```ruby
	<%= listy_links BlogPost.all, :title %>
	
	<%= listy_links User.all, :email, :show_more => true %>
	
	<%= listy_links Product.all, :part_number, :show_more => true, :show_more_limit => 100, :css_class => "products-list" %>
```

### listy_tree

	listy_tree(collection, spec, options={})

This method is for creating a nested tree of unordered lists for a collection with nested collections. 
This is suitable for Rails models that have has_many relationships. The lists will be collapsable if you click on the parent elements (requires JQuery and listy.js, please read above).
The spec is basically instructions on how to create the nested tree. It is a nested hash where each child specifies how to create the nested list

Example let's say we have the following

* Country which has_many States
* State which has_many Cities

Examples:

```ruby
	listy_tree(Country.all, 
				{ :display_method_name => :name, 
				  :children => :states, 
				  :child => { :display_method_name => :name, 
							  :children => :cities, 
							  :child => { :display_method_name => :name }
							}
				 })
```

Be sure that the inner most child of the spec has :children => nil (or just leave it undefined). This will stop the nesting.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
