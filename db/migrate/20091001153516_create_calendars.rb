class CreateCalendars < ActiveRecord::Migration
  def self.up
    create_table :calendars do |t|
      t.string :event
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
    
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :calendars_categories, :id => false do |t|
      t.integer :calendar_id
      t.integer :category_id
    end
    
  end

  def self.down
    drop_table :calendars
    drop_table :categories
    drop_table :calendars_categories
  end
end
