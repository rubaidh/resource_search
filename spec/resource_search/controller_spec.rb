require "#{File.dirname(__FILE__)}/../spec_helper"

class FooController < ApplicationController
  resource_search
  
  def index
  end
end

class Foo < ActiveRecord::Base
end

describe FooController, "checking that the resource search has been included correctly", :type => :controller do
  it "should have been extended with the acts method" do
    controller.class.methods.include?("resource_search").should be_true
  end

  it "should have been extended with the class methods" do
    controller.class.methods.include?("params_key").should be_true
    controller.class.methods.include?("resource_model").should be_true
  end

  it "should have been extended with the instance methods" do
    controller.private_methods.include?("params_key").should be_true
    controller.private_methods.include?("resource_model").should be_true
  end
end

describe FooController, "checking the conversions between controller & resource name", :type => :controller do
  # FIXME: I'm not sure that asking private interfaces for their results
  # is a good idea, although it has helped the implementation to ensure
  # that works...
  it "should attempt to search on the Foo model" do
    controller.send(:resource_model).should be(Foo)
  end

  it "should be looking for params in the :foo hash" do
    controller.send(:params_key).should == :foo
  end
end

describe FooController, "checking that the resource search has been hooked into the filter chain", :type => :controller do
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

  it "should have process_search_terms in the around_filter chain" do
    controller.class.filter_chain.map(&:filter).include?(:process_search_terms).should be_true
  end
end