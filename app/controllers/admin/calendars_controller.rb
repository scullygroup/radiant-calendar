class Admin::CalendarsController < ApplicationController
  
    def index
      @events = Calendar.find(:all, :order => "start_date ASC")

      respond_to do |format|
        format.html
      end
    end

    def show
      @calendar = Calendar.find(params[:id])

      render :layout => false
    end

    def new
      @calendar = Calendar.new

      respond_to do |format|
        format.html
      end
    end

    def edit
      @calendar = Calendar.find(params[:id])

      respond_to do |format|
        format.html
      end
    end

    def create
      @calendar = Calendar.create(params[:calendar])

      respond_to do |format|
        if @calendar.save
          flash[:notice] = 'Calendar was successfully created.'
          format.html { redirect_to("/admin/calendars/#{Time.now.strftime('%Y-%m-%d')}") }
        else
          format.html { render :action => "new" }
        end
      end
    end

    def update
      params[:calendar][:category_ids] ||= []
      @calendar = Calendar.find(params[:id])

      respond_to do |format|
        if @calendar.update_attributes(params[:calendar])
          flash[:notice] = 'Calendar was successfully updated.'
          format.html { redirect_to("/admin/calendars/#{Time.now.strftime('%Y-%m-%d')}") }
        else
          format.html { render :action => "edit" }
        end
      end
    end

    def destroy
      @calendar = Calendar.find(params[:id])

      @calendar.destroy

      respond_to do |format|
        flash[:notice] = 'Calendar event has been deleted.'
        format.html { redirect_to("/admin/calendars/#{Time.now.strftime('%Y-%m-%d')}") }
      end
    end
    
end
