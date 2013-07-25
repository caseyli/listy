module Listy
  module ViewHelpers
 
    def listy_tree(collection, spec, options={})
      css_class = options[:css_class] || ""
      if collection.present?
        html = "<div class='listy-tree " + css_class + "'>" + create_listy_tree(collection, spec, "", 0) + "</div>"
      else
        html = options[:empty_message] || "There are no entries in this list."
      end
      raw html
    end
    
    
 
    def listy_links(collection, options={})
      if collection.present?
        css_class = options[:css_class] || ""
        html = "<ul class='" + css_class + "'>"
        show_more_limit_reached = false

        show_more_limit = options[:show_more_limit] || 10 if options[:show_more]

        collection.each_with_index do |element, index|

          if options[:show_more] && (index+1) > show_more_limit && !show_more_limit_reached
            html += "<div class='listy-show-more-list' style='display:none'>" 
            show_more_limit_reached = true
          end
          display = options[:display_method].nil? ? element.to_s : element.try(options[:display_method])
          html += "<li>" + link_to(display, element) + "</li>"
        end

        if options[:show_more] && show_more_limit_reached
          html += "</div>" 
          html += link_to("Show More", "#", :class => "listy-show-more-link button orange-button")
        end 

        html += "</ul>"
      else
        html = options[:empty_message] || "There are no entries in this list."
      end

      raw html
    end

    def multi_column_listy_links(collection, number_of_columns, options={})
      html = ""
      if collection.present?
        number_of_entries_per_column = (Float(collection.size)/Float(number_of_columns)).ceil
        percentage_width_of_column = 100 / number_of_columns
        Rails.logger.info(collection.size.to_s + " " + number_of_entries_per_column.to_s)
        (0..number_of_columns-1).each do |i|
          html += "<div style='float:left;width:" + percentage_width_of_column.to_s + "%'>"

          start_index = i * number_of_entries_per_column
          end_index = (i+1) * number_of_entries_per_column - 1
          end_index = collection.size if end_index > collection.size

          html += listy_links(collection[start_index..end_index], options)

          html += "</div>"
        end

        html += "<div style='clear:both'></div>"

      else
        html = options[:empty_message] || "There are no entries in this list."
      end

      raw html
    end
    
    private
      def create_listy_tree(collection, spec, html, level)
        html += "<ul class='listy-tree-level-#{level}'>"

        collection.each do |element|
          html += "<li>"
          display = spec[:display_method].nil? ? element.to_s : element.try(spec[:display_method])
          html += "<div class='listy-tree-list-header'>#{display}</div>"
          html = create_listy_tree(element.try(spec[:children]), spec[:child], html, level+1) if !spec[:children].nil?
          html += "</li>"
        end

        html += "</ul>"      
      end
 
  end
end