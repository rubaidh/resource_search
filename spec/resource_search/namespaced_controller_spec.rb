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

describe Name::SpacedController, "checking the conversions between controller & resource name", :type => :controller do
  # FIXME: I'm not sure that asking private interfaces for their results
  # is a good idea, although it has helped the implementation to ensure
  # that works...
  it "should attempt to search on the Spaced model" do
    controller.send(:resource_model).should be(Spaced)
  end

  it "should be looking for params in the :spaced hash" do
    controller.send(:params_key).should == :spaced
  end
end