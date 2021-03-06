ActionController::Routing::Routes.draw do |map|
  
  map.connect '/daily_event/:id', :controller => 'calendars', :action => 'daily_list'
  map.connect '/calendar_list/:id', :controller => 'calendars', :action => 'calendar_list'
  map.connect '/main_calendar/:id', :controller => 'calendars', :action => 'index'
  map.connect '/calendars/show/:id', :controller => 'calendars', :action => 'show'
  map.connect '/filter/calendar', :controller => 'calendars', :action => 'filter'
  map.connect '/:category/calendar', :controller => 'calendars', :action => 'filter'
  map.connect '/subscribe', :controller => 'calendars', :action => 'subscribe'
  map.connect '/subscribe_selected', :controller => 'calendars', :action => 'subscribe_selected'
  map.connect '/events/:id', :controller => 'calendars', :action => 'export_events'
  map.connect '/daily_events/:id', :controller => 'calendars', :action => 'export_daily_events'
  map.connect '/events/:id/:category', :controller => 'calendars', :action => 'export_selected_events'
  map.connect '/event/:id', :controller => 'calendars', :action => 'export_event'

  map.resources :calendars
  map.resources :categories

  map.with_options(:controller => 'admin/calendars') do |calendar|
    calendar.calendar_index           'admin/calendars',        :action => 'index'
    calendar.calendar_new             'admin/calendars/new',          :action => 'new'
    calendar.calendar_create          'admin/calendars/create',       :action => 'create'
    calendar.calendar_date            'admin/calendars/:id',          :action => 'index'
    calendar.calendar_show            'admin/calendars/show/:id',     :action => 'show'   
    calendar.calendar_edit            'admin/calendars/edit/:id',     :action => 'edit'
    calendar.calendar_update          'admin/calendars/update/:id',   :action => 'update'  
    calendar.calendar_remove          'admin/calendars/destroy/:id',  :action => 'destroy'
  end

  map.with_options(:controller => 'admin/categories') do |category|
    category.category_index           'admin/categories',             :action => 'index'
    category.category_show            'admin/categories/show/:id',    :action => 'show'   
    category.category_new             'admin/categories/new',         :action => 'new'
    category.category_create          'admin/categories/create',      :action => 'create'
    category.category_edit            'admin/categories/edit/:id',    :action => 'edit'
    category.category_update          'admin/categories/update/:id',  :action => 'update'  
    category.category_remove          'admin/categories/destroy/:id', :action => 'destroy'
  end
  
end