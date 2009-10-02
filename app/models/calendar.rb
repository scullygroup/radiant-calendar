class Calendar < ActiveRecord::Base
  
  has_and_belongs_to_many :categories
  
  validates_presence_of :event, :description, :start_date, :end_date
  
end