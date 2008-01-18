require "#{File.dirname(__FILE__)}/../spec_helper"

class ResourceWithManySearchActionController < ApplicationController
  resource_search :only => [:index, :titles, :people]
  
  def index
  end
end

class ResourceWithManySearchAction < ActiveRecord::Base 
end

describe ResourceWithManySearchActionController, "checking that the resource search has been hooked into the filter chain", :type => :controller do
  before(:each) do
    @filter = controller.class.filter_chain.find { |fc| fc.filter == :process_search_terms }
  end

  it "should have process_search_terms in the around_filter chain" do
    controller.class.filter_chain.include?(@filter).should be_true
  end

  it "should only have process_search_terms attached to the index action" do
    controller.class.included_actions.should == { @filter => ["index", "titles", "people"] }
  end
end