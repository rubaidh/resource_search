require "#{File.dirname(__FILE__)}/../spec_helper"

class ResourceController < ApplicationController
  resource_search
  
  def index
  end
end

class Resource < ActiveRecord::Base
end

describe ResourceController, "checking that the resource search has been included correctly", :type => :controller do
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

describe ResourceController, "checking the conversions between controller & resource name", :type => :controller do
  # FIXME: I'm not sure that asking private interfaces for their results
  # is a good idea, although it has helped the implementation to ensure
  # that works...
  it "should attempt to search on the Resource model" do
    controller.send(:resource_model).should be(Resource)
  end

  it "should be looking for params in the :resource hash" do
    controller.send(:params_key).should == :resource
  end
end

describe ResourceController, "checking that the resource search has been hooked into the filter chain", :type => :controller do
  before(:each) do
    @filter = controller.class.filter_chain.find { |fc| fc.filter == :process_search_terms }
  end

  it "should have process_search_terms in the around_filter chain" do
    controller.class.filter_chain.include?(@filter).should be_true
  end

  it "should only have process_search_terms attached to the index action" do
    controller.class.included_actions.should == { @filter => ["index"] }
  end
end