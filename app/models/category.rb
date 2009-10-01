class Category < ActiveRecord::Base
  
  has_and_belongs_to_many :calendars
  
  validates_presence_of :name
  
end
