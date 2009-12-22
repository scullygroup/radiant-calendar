class Calendar < ActiveRecord::Base
  
  has_and_belongs_to_many :categories
  
  validates_presence_of :event, :description, :start_date, :end_date
  
  attr_accessible :event, :description, :category_ids, :start_date, :end_date, :start_time, :end_time
  
  # Find all events from the current day into the future
  def self.current_events(date)
    start_date_gte(date).ascend_by_start_date
  end
  
  # Find all events on the selected day
  def self.day_events(date)
    end_date_gte(date).start_date_like_or_start_date_lte(date).ascend_by_start_date
  end
  
  # Find all events for the chosen category
  def self.filter_events(month, category)
    find(:all, :joins => :categories, :conditions => ["start_date >= ? AND categories.id in (?)", month, category])
    #find(:all, :joins => :categories, :group => "calendars.id", :select => "calendars.*", :conditions => ["start_date >= ? AND categories.id in (?)", month, category])
  end
  
  # Find all events for the chosen category
  def self.subscribe_selected(category)
    find(:all, :joins => :categories, :conditions => ["categories.id in (?)", category])
  end
  
end