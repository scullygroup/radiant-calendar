require 'icalendar'

class CalendarsController < ApplicationController
  
  no_login_required
  radiant_layout 'Calendar'
  
  include CalendarsHelper
  
  def index
    @events = Calendar.find(:all, :order => "start_date ASC")

    respond_to do |format|
      format.html
    end
  end

# show end-user view of calendar
  def calendar_list
    params[:id] = "#{Time.now.strftime('%Y-%m-%d')}" if !params[:id]
    @events = Calendar.current_events(params[:id])

    @daily_events = @events.group_by { |d| d.start_date }

    respond_to do |format|
      format.html
    end
  end

# show all events for the chosen day
  def daily_list
    @events = Calendar.day_events(params[:id])
    @daily_events = @events.group_by { |d| d.start_date }

    respond_to do |format|
      format.html { render :template => '/calendars/calendar_list' }
    end
  end

# show calendar for the chosen categories
  def categories
    if !is_a_number?(params[:category])
      c = Category.find_by_name(params[:category])
      cat = c.id
    else
      cat = params[:category]
    end
    params[:id] = Time.now.strftime("%Y-%m-%d") if !params[:id]
    if cat
      start = DateTime.strptime("#{params[:id]}T00:00:00+00:00")
      month = start.strftime("%Y-%m")
      
      @events = Calendar.filter_events(month, cat)
        
      @daily_events = @events.group_by { |d| d.start_date }
    else
      start = DateTime.strptime("#{params[:id]}T00:00:00+00:00")
      month = start.strftime("%Y-%m")
      @events = Calendar.current_events(params[:id])
      @daily_events = @events.group_by { |d| d.start_date }
    end
  end

  def filter
    self.categories

    respond_to do |format|
      format.html {render :template => "/calendars/calendar_list"}
    end
  end

  def show
    @calendar = Calendar.find(params[:id])

    render :layout => false
  end


# Build the ical file from @events
  def build_ical
    @calendar = Icalendar::Calendar.new

    for cal in @events
      event = Icalendar::Event.new
      event.start = cal.start_date.strftime("%Y%m%d") + cal.start_time.strftime("T%H%M%S")
      event.end = cal.end_date.strftime("%Y%m%d") + cal.end_time.strftime("T%H%M%S")
      event.summary = cal.event
      event.description = cal.description
      #event.location = cal.location
      @calendar.add event
    end    

    @calendar.publish

    send_data(@calendar.to_ical, :type => 'text/calendar', :filename => 'ical.ics')
  end

# Subscribe to an ics feed for the entire calendar
  def subscribe
    @events = Calendar.all

    respond_to do |format|
      format.ics  { render :text => self.subscribe_events}
    end
  end
  
# Subscribe to an ics feed for tthe selected category
  def subscribe_selected
    cat = params[:category].split(',')
    if cat
      @events = Calendar.subscribe_selected(cat)
    else
      @events = Calendar.current_events(Time.now.strftime("%Y-%m-%d"))
    end

    respond_to do |format|
      format.ics  { render :text => self.subscribe_events}
    end
  end
    

  def subscribe_events
    @calendar = Icalendar::Calendar.new

    for cal in @events
      event = Icalendar::Event.new
      event.start = cal.start_date.strftime("%Y%m%d") + cal.start_time.strftime("T%H%M%S")
      event.end = cal.end_date.strftime("%Y%m%d") + cal.end_time.strftime("T%H%M%S")
      event.summary = cal.event
      event.description = cal.description
      #event.location = cal.location
      @calendar.add event
    end    

    @calendar.publish
    @calendar.to_ical
  end

# Export all events as an ics file
  def export_events    
    @events = Calendar.find(:all) do
      start_date >= params[:id]
      order_by start_date
    end

    self.build_ical
  end

# Export all events on the chosen day as an ics file
  def export_daily_events    
    @events = Calendar.find(:all) do
      end_date >= params[:id]
      any do
        start_date.contains? params[:id]
        start_date <= params[:id]
      end
      order_by start_date
    end

    self.build_ical
  end

# Export all events from selected categories as an ics file
  def export_selected_events

    cat = params[:category]
    cat = cat.split(",")

    @events = Calendar.find(:all) do
      any do
        cat.each do |c|
          categories.id == "#{c}"
        end
      end
      start = DateTime.strptime("#{params[:id]}T00:00:00+00:00")
      month = start.strftime("%Y-%m-01")

      start_date >= month
      order_by start_date
    end

    self.build_ical
  end

# Export a single event as an ics file
  def export_event
    @event = Calendar.find(params[:id])

    @calendar = Icalendar::Calendar.new

    event = Icalendar::Event.new
    event.start = @event.start_date.strftime("%Y%m%d") + @event.start_time.strftime("T%H%M%S")
    event.end = @event.end_date.strftime("%Y%m%d") + @event.end_time.strftime("T%H%M%S")
    event.summary = @event.event
    event.description = @event.description
    #event.location = @event.location

    @calendar.add event 
    @calendar.publish

    send_data(@calendar.to_ical, :type => 'text/calendar', :filename => 'ical.ics')
  end
    
end
