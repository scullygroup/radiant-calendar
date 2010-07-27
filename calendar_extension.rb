# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class CalendarExtension < Radiant::Extension
  version "1.0"
  description "Radian CMS Calendar Extension"
  url "http://github.com/scullygroup/radiant-calendar"
  
  def activate
    
    tab "Calendar" do
      add_item 'Show All Events', "/admin/calendars"
      add_item 'Add New Event', "/admin/calendars/new"
      add_item 'Show All Categories', "/admin/categories"
      add_item 'Add New Category', "/admin/categories/new"
    end
    
    ApplicationHelper.class_eval do
      # slugify takes the content of params[:event_type] and strips out all the special characters to make a web friendly slug
      def slugify(urlstring)
        urlstring = urlstring.downcase.strip
        urlstring = urlstring.gsub(/\([A-Za-z0-9\.\s]*\)/, "")
        urlstring = urlstring.gsub(/[^A-Za-z0-9\s]/, "").strip
        urlstring = urlstring.gsub(/\s+/, "-")

        return urlstring
      end

      # titleify strips out the ()'s, lowercases all word characters, and then formats the title in proper english via the titleize gem
      def titleify(urlstring)
        urlstring = urlstring.downcase.strip
        urlstring = urlstring.gsub(/\([A-Za-z0-9\.\s]*\)/, "")
        urlstring = urlstring.gsub(/[-]+/, " ")
        urlstring = urlstring.gsub(/\s+/, " ")
        urlstring = urlstring.titleize

        return urlstring
      end
    end
    #Page.send :include, CalendarTags
    
    # Page.class_eval do
    #   belongs_to :populator
    # end
        
  end
  
  # def deactivate
  #   admin.tabs.remove "Calendar"
  # end
  
end
