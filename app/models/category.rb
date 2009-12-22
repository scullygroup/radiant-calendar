class Category < ActiveRecord::Base
  
  include CalendarsHelper
  
  has_and_belongs_to_many :calendars
  
  validates_presence_of :name
  
  attr_accessible :name
  
  before_save :sanitize_name
  
  def sanitize_name
    self.name = slugify(name)
  end
  
end
