require "#{File.dirname(__FILE__)}/../spec_helper"

module Name
  class SpacedController < ApplicationController
    resource_search

    def index

    end
  end
end

class Spaced < ActiveRecord::Base
end

describe Name::SpacedController, "handling GET / (index)", :type => :controller do
  before(:each) do
    Spaced.stub!(:find).and_return([])
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
  it "should attempt to search on the Spaced model" do
    do_get
    controller.send(:resource_model).should be(Spaced)
  end

  it "should be looking for params in the :spaced hash" do
    do_get
    controller.send(:params_key).should == :spaced
  end
end