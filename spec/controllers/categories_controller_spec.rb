require File.dirname(__FILE__) + '/../spec_helper'

describe CategoriesController do

  #Delete these examples and add some real ones
  it "should use CategoriesController" do
    controller.should be_an_instance_of(CategoriesController)
  end


  it "GET 'admin/categories' should be successful" do
    get 'admin/categories'
    response.should be_success
  end
end
