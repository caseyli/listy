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

## Rails Helpers Usage

There are a couple of helper methods including:

### listy_links

	listy_links(collection, options={})

This method creates a simple unordered list of links of the elements in the collection. This is suitable for Ruby on Rails models.

* collection - Should be an ActiveRecord collection.

Options you can pass in include

* :display_method - Symbol of method to be called on each record to generate what is displayed in the list. If you set is not specified, to_s will be called on the element to generate the display string.
* :css_class - The class that is applied to the resulting ul list element
* :empty_message - The message that is displayed if the collection is empty
* :show_more - If set to true, the list will display only the first 10 elements, and hide the rest and create a "Show More" link. Show more functionality requires JQuery and list.js - please read above.
* :show_more_limit - If you want more that the first 10 elements to show when show_more is set to true, then specify that limit here.

#### Example Usage:

```ruby
	<%= listy_links BlogPost.all %>  <!-- probably not that useful -->
	
	<%= listy_links BlogPost.all, :display_method => :title %>
	
	<%= listy_links User.all, :display_method => :email, :show_more => true %>
	
	<%= listy_links Product.all, :display_method => :part_number, :show_more => true, :show_more_limit => 100, :css_class => "products-list" %>
```


### multi_column_listy_links

	multi_column_listy_links(collection, number_of_columns, options={})

This does the same thing as listy_links but presents it in the number of columns you specify.

* collection - Should be an ActiveRecord collection.
* number_of_columns - The number of columns you want the list split up into.

Options you can pass in include:

* :display_method - Symbol of method to be called on each record to generate what is displayed in the list. If you set is not specified, to_s will be called on the element to generate the display string.
* :css_class - The class that is applied to the resulting ul list elements in each column
* :empty_message - The message that is displayed if the collection is empty

#### Example Usage:

```ruby
	<%= multi_column_listy_links BlogPost.all, 3, :display_method => :title %>
	
	<%= multi_column_listy_links User.all, 2, :display_method => :email %>
	
	<%= multi_column_listy_links Product.all, 4, :display_method => :part_number, :css_class => "products-list", :empty_message => "There are no products" %>
```


### listy_tree

	listy_tree(collection, spec, options={})

This method is for creating a nested tree of unordered lists for a collection with nested collections. 
This is suitable for Rails models that have has_many relationships. The lists will be collapsable if you click on the parent elements (requires JQuery and listy.js, please read above).

The spec is basically instructions on how to create the nested tree. It is a nested hash where each child specifies how to create the nested list.

* collection - Collection, usually nested, of elements, usually ActiveRecord's with has_many relationships
* spec - explained below

Options you can pass in include:

* :css_class - The class that is applied to the resulting div tag that surrounds the nested lists
* :empty_message - The message that is displayed if the collection is empty

#### CSS Classes

Each nested ul element ends up being assigned a class. The upper most ul has a css class of `listy-tree-level-0` and the next one has a css class of `listy-tree-level-1` and so on.

Also, with the collapsing and expanding of the list, the following classes also are applied and taken away to the headers of the lists `listy-list-header-expanded` and `listy-list-header-collapsed`. This way you can style what the header looks like when you expand or collapse the list.

Lastly, the leafs of a listy-tree have the css class `listy-tree-leaf`.

Basically this are all used for custom styling.


#### Spec Explanation

The spec is a nested hash that contains the following elements:

* :display_method - Symbol of method to be called on each record to generate what is displayed in the list. If you set is not specified, to_s will be called on the element to generate the display string.
* :children - The name of the method (typically the has_many relationship) to call to get the nested collection (leave unspecified or nil if this is the leaf node)
* :child - The spec for the elements of the children (leave unspecified or nil if this is the leaf node)

Here's a sample spec

Let's say we have the following

* Country which has_many States
* State which has_many Cities


```ruby
	spec = { :display_method => :name, 
	  			:children => :states, 
	  			:child => { :display_method => :name, 
				  			:children => :cities, 
				  			:child => { :display_method => :name }
						   }
	 		}
```



#### Example Usage:

```ruby
	listy_tree(Country.all, 
				{ :display_method => :name, 
				  :children => :states, 
				  :child => { :display_method => :name, 
							  :children => :cities, 
							  :child => { :display_method => :name }
							}
				 })
```

Be sure that the inner most child of the spec has :children => nil (or just leave it undefined). This will stop the nesting.

## JQuery based Javascript Functions

Aside from the javascript functions that are used by the generated elements (like the Show More button), there are some javascript functions that might be useful to users described below.

### autoCollapseAllListyBranchesBut

	autoCollapseAllListyBranchesBut(headerName, tree)
	
This method is handy to collapse all branches of a listy_tree with the exception of a branch that has a header that matches the passed in headerName.

* headerName - The text to match. If a list in the listy_tree has a header that matches this value, it will be left alone. All other lists will be collapsed.
* tree - The listy tree element. If using JQuery, you can pass in something like $(".listy-tree listy-tree-level-1")

#### Example Usage:

```javascript
	autoCollapseAllListyBranchesBut("Products", $(".listy-tree listy-tree-level-1"));
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
