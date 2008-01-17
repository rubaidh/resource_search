require "#{File.dirname(__FILE__)}/../spec_helper"

class UnaffectedController < ApplicationController
  def index
    
  end
end

class Unaffected < ActiveRecord::Base
  
end

describe UnaffectedController, "handling GET / (index)", :type => :controller do
  before(:each) do
    Unaffected.stub!(:find).and_return([])
  end

  def do_get
    get :index
  end

  it "should have been extended with the acts method" do
    controller.class.methods.include?("resource_search").should be_true
  end

  it "should not have been extended with the class methods" do
    controller.class.methods.include?("params_key").should be_false
    controller.class.methods.include?("resource_model").should be_false
  end

  it "should not have been extended with the instance methods" do
    controller.private_methods.include?("params_key").should be_false
    controller.private_methods.include?("resource_model").should be_false
  end

  it "should not have process_search_terms in the around_filter chain" do
    controller.class.filter_chain.map(&:filter).include?(:process_search_terms).should be_false
  end
end