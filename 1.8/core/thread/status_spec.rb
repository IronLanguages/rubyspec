require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/fixtures/classes'

describe "Thread#status" do
  it "reports threads as running and returns false on correct termination" do
    t = Thread.new { Thread.current.status }
    t.value.should == 'run'
    t.status.should == false
  end

  ironruby_bug("21171: Marshal exceptions thrown within thread blocks properly to calling thread") do
    it "returns nil if thread terminates with exception" do
      t = Thread.new { raise "test exception" }
      lambda { t.join }.should raise_error(StandardError)
      t.status.should == nil
    end
  end
end
