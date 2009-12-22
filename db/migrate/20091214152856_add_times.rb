class AddTimes < ActiveRecord::Migration
  def self.up
    add_column :calendars, :start_time, :time
    add_column :calendars, :end_time, :time
  end

  def self.down
    remove_column :calendars, :end_time
    remove_column :calendars, :start_time
  end
end
