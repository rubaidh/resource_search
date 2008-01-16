require 'rubaidh/core_ext/enumerable'

describe "The unzip method added to enumerable" do
  it "should be available as a method on Array" do
    Array.instance_methods.include?('unzip').should be_true
  end
end