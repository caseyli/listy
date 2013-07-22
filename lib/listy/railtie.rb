require 'listy/view_helpers'

module Listy
  class Railtie < Rails::Railtie
    initializer "listy.view_helpers" do |app|
      ActionView::Base.send :include, ViewHelpers
    end
  end 
end