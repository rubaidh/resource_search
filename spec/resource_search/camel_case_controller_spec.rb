require "#{File.dirname(__FILE__)}/../spec_helper"

class CamelCaseController < ApplicationController
  resource_search
  
  def index
    
  end
end

class CamelCase < ActiveRecord::Base
end

describe CamelCaseController, "handling GET / (index)", :type => :controller do
  before(:each) do
    CamelCase.stub!(:find).and_return([])
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
  it "should attempt to search on the CamelCase model" do
    do_get
    controller.send(:resource_model).should be(CamelCase)
  end

  it "should be looking for params in the :camel_case hash" do
    do_get
    controller.send(:params_key).should == :camel_case
  end
end