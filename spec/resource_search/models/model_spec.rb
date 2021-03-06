require "#{File.dirname(__FILE__)}/../../spec_helper"

class Foo < ActiveRecord::Base
end

describe Foo, "checking that the extensions have been correctly included" do
  it "should have been extended with the class methods" do
    Foo.methods.include?("with_search_terms").should be_true
  end
end