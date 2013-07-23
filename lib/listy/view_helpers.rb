module Listy
  module ViewHelpers
 
    def listy_tree(collection, spec, options={})
      if collection.present?
        html = "<div class='listy-tree'>" + create_listy_tree(collection, spec, "", 0) + "</div>"
      else
        html = "There are no entries in this tree."
        html = options[:empty_message] if !options[:empty_message].nil?
      end
      raw html
    end
    
    
 
    def listy_links(collection, display_method_name, options={})
      if collection.present?
        html = "<ul class='" + options[:css_class] + "'>"
        show_more_limit_reached = false

        show_more_limit = options[:show_more_limit] || 10 if options[:show_more]

        collection.each_with_index do |element, index|

          if options[:show_more] && (index+1) > show_more_limit && !show_more_limit_reached
            html += "<div class='listy-show-more-list' style='display:none'>" 
            show_more_limit_reached = true
          end
          display = display_method_name.nil? ? element.to_s : element.try(display_method_name)
          html += "<li>" + link_to(display, element) + "</li>"
        end

        if options[:show_more] && show_more_limit_reached
          html += "</div>" 
          html += link_to("Show More", "#", :class => "listy-show-more-link button orange-button")
        end 

        html += "</ul>"
      else
        html = "There are no entries in this list."
        html = options[:empty_message] if !options[:empty_message].nil?
      end

      raw html
    end

    def multi_column_listy_links(collection, display_method_name, number_of_columns, options={})
      html = ""
      if collection.present?
        number_of_entries_per_column = collection.size/number_of_columns
        percentage_width_of_column = 100 / number_of_columns
        Rails.logger.info(collection.size.to_s + " " + number_of_entries_per_column.to_s)
        (0..number_of_columns-1).each do |i|
          html += "<div style='float:left;width:" + percentage_width_of_column.to_s + "%'>"

          start_index = i * number_of_entries_per_column
          end_index = (i+1) * number_of_entries_per_column
          end_index = collection.size if end_index > collection.size

          html += listy_links(collection[start_index..end_index], display_method_name, options)

          html += "</div>"
        end

        html += "<div style='clear:both'></div>"

      else
        html = "There are no entries in this list."
        html = options[:empty_message] if !options[:empty_message].nil?
      end

      raw html
    end
    
    private
      def create_listy_tree(collection, spec, html, level)
        html += "<ul class='listy-tree-level-#{level}'>"

        collection.each do |element|
          html += "<li>"
          html += "<div class='listy-tree-list-header'>#{element.try(spec[:display_method_name])}</div>"
          html = create_listy_tree(element.try(spec[:children]), spec[:child], html, level+1) if !spec[:children].nil?
          html += "</li>"
        end

        html += "</ul>"      
      end
 
  end
end