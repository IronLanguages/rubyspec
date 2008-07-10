require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/fixtures/classes'

describe "Kernel#`" do
  it "is a private method" do
    Kernel.private_instance_methods.should include("`")
  end
  
  it "returns the standard output of the executed sub-process" do
    ip = 'world'
    platform_is_not :windows do
      `echo disc #{ip}`.should == "disc world\n"
    end
    platform_is :windows do
      `echo disc #{ip}`.should == "disc world\r\n"
    end
  end
  
  it "tries to convert the given argument to String using #to_str" do
    (obj = mock('echo test')).should_receive(:to_str).and_return("echo test")
    if platform_is_not :windows
      Kernel.`(obj).should == "test\n"
    else
      Kernel.`(obj).should == "test\r\n"
    end
  end

  it "checks whether the passed argument responds to #to_str" do
    obj = mock('echo another test')
    obj.should_receive(:respond_to?).with(:to_str).any_number_of_times.and_return(true)
    obj.should_receive(:method_missing).with(:to_str).and_return("echo another test")
    if platform_is_not :windows
      Kernel.`(obj).should == "another test\n"
    else
      Kernel.`(obj).should == "another test\r\n"
    end
  end
  
  platform_is_not :windows do
    it "sets $? to the exit status of the executed sub-process" do
      ip = 'world'
      `echo disc #{ip}`
      $?.class.should == Process::Status
      $?.stopped?.should == false
      $?.exited?.should == true
      $?.exitstatus.should == 0
      $?.success?.should == true
      `echo disc #{ip}; exit 99`
      $?.class.should == Process::Status
      $?.stopped?.should == false
      $?.exited?.should == true
      $?.exitstatus.should == 99
      $?.success?.should == false
    end
  end

  platform_is :windows do
    it "sets $? to the exit status of the executed sub-process" do
      ip = 'world'
      `echo disc #{ip}`
      $?.class.should == Process::Status
      $?.stopped?.should == false
      $?.exited?.should == true
      $?.exitstatus.should == 0
      $?.success?.should == true
      `echo disc #{ip}& exit 99`
      $?.class.should == Process::Status
      $?.stopped?.should == false
      $?.exited?.should == true
      $?.exitstatus.should == 99
      $?.success?.should == false
    end
  end
end

describe "Kernel.`" do
  it "needs to be reviewed for spec completeness" do
  end
end
