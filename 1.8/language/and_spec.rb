require File.dirname(__FILE__) + '/../spec_helper'

describe "The '&&' statement" do
  
  it "short-circuits evaluation at the first condition to be false" do
    x = nil
    true && false && x = 1
    x.should be_nil
  end
  
  it "evalutes to the first condition not to be true" do
    ("yes" && 1 && nil && true).should == nil
    ("yes" && 1 && false && true).should == false
  end
  
  it "evalutes to the last condition if all are true" do
    ("yes" && 1).should.equal 1
    (1 && "yes").should.equal "yes"
  end
  
  it "evaluates the full set of chained conditions during assignment" do
    x, y = nil
    x = 1 && y = 2
    # "1 && y = 2" is evaluated and then assigned to x
    x.should == 2
  end

end

describe "The 'and' statement" do
  it "short-circuits evaluation at the first condition to be false" do
    x = nil
    true and false and x = 1
    x.should be_nil
  end
  
  it "evalutes to the first condition not to be true" do
    ("yes" and 1 and nil and true).should == nil
    ("yes" and 1 and false and true).should == false
  end
  
  it "evalutes to the last condition if all are true" do
    ("yes" and 1).should.equal 1
    (1 and "yes").should.equal "yes"
  end
  
  it "when used in assignment, evaluates and assigns expressions individually" do
    x, y = nil
    x = 1 and y = 2
    # evaluates (x=1) and (y=2)
    x.should == 1
  end
  
end
