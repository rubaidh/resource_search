require "#{File.dirname(__FILE__)}/../spec_helper"
require 'rubaidh/core_ext/enumerable'

describe "The unzip method added to enumerable" do
  it "should be available as a method on Array" do
    Array.instance_methods.include?('unzip').should be_true
  end
  
  it "should reverse the action of zip" do
    [1, 2, 3].zip([4, 5, 6]).unzip.should == [[1, 2, 3], [4, 5, 6]]
    
    [1, 2].zip([3]).unzip.should == [[1, 2], [3]]
    
    [1, 2, 3, 4, 5].zip([10, 20, 30, 40, 50]).unzip.should == [[1, 2, 3, 4, 5], [10, 20, 30, 40, 50]]
  end
end