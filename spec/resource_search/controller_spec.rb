require "#{File.dirname(__FILE__)}/../spec_helper"

class FooController < ApplicationController
  resource_search
  
  def index
    
  end
end

class Foo < ActiveRecord::Base
end

describe FooController, "handling GET / (index)", :type => :controller do
  before(:each) do
    Foo.stub!(:find).and_return([])
  end

  def do_get
    get :index
  end

  it "should succeed" do
    do_get
    response.should be_success
  end

  # FIXME: I'm not sure that asking private interfaces for their results
  # is a good idea, although it has helped the implementation to ensure
  # that works...
  it "should attempt to search on the Foo model" do
    do_get
    controller.send(:resource_model).should be(Foo)
  end

end