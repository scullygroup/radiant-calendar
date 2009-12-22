class Admin::CategoriesController < ApplicationController
  
  include Admin::CategoriesHelper
  
  def index
    @categories = Category.all

    respond_to do |format|
      format.html
    end
  end

  def show
    redirect_to("/admin/categories")
  end

  def new
    @category = Category.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @category = Category.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end

  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        format.html { redirect_to("/admin/categories") }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @category = Category.find(params[:id])
    
    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to("/admin/categories") }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      flash[:notice] = 'Category has been deleted.'
      format.html { redirect_to("/admin/categories") }
    end
  end
end