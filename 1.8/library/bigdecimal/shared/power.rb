require 'bigdecimal'

shared :bigdecimal_power do |cmd|

  describe "BigDecimal##{cmd}" do

    it "powers of self" do
      BigDecimal("3E20001").send(cmd, 0).should == 1
      BigDecimal("3E-20001").send(cmd, 1).should == BigDecimal("3E-20001")
      BigDecimal("3E-20001").send(cmd, 2).should == BigDecimal("9E-40002")
      
      BigDecimal("2E40001").send(cmd, -1).should == BigDecimal("5E-40002")
      BigDecimal("2E40001").send(cmd, -1).should == BigDecimal("5E-40002").power(1)
      
      (BigDecimal("2E40001").send(cmd, -1) * BigDecimal("5E-40002").send(cmd, -1)).should == 1
      
      e = BigDecimal("1.00000000000000000000123456789")
      tolerance = BigDecimal("1E-95")
      e.send(cmd, 2).should == e * e
#      e.send(cmd, -1).should be_close(BigDecimal("1").div(e, 120), tolerance)

      BigDecimal("10").send(cmd, 10000).should == BigDecimal("1E10000")
      
      BigDecimal("3.14159265358979").send(cmd, 10).should be_close(Math::PI ** 10, TOLERANCE)
    end

    it "powers of 1 equal 1" do
      one = BigDecimal("1")
      one.send(cmd, 0).should == 1
      one.send(cmd, 1).should == 1
      one.send(cmd, 10).should == 1
      one.send(cmd, -10).should == 1
    end

    it "0 to power of 0 is 1" do
      zero = BigDecimal("0")
      zero.send(cmd, 0).should == 1
    end

    it "0 to powers < 0 is Infinity" do
      zero = BigDecimal("0")
      infinity = BigDecimal("Infinity")
      zero.send(cmd, -10).should == infinity
      zero.send(cmd, -1).should == infinity
    end

    it "other powers of 0 are 0" do
      zero = BigDecimal("0")
      zero.send(cmd, 1).should == 0
      zero.send(cmd, 10).should == 0
    end
    
    it "returns NaN if self is NaN" do
      BigDecimal("NaN").send(cmd, -5).nan?.should == true
      BigDecimal("NaN").send(cmd, 5).nan?.should == true
    end

    it "returns NaN if self is infinite" do
      BigDecimal("Infinity").send(cmd, -5).nan?.should == true
      BigDecimal("-Infinity").send(cmd, -5).nan?.should == true
      BigDecimal("Infinity").send(cmd, 5).nan?.should == true
      BigDecimal("-Infinity").send(cmd, 5).nan?.should == true
    end

  end

end
