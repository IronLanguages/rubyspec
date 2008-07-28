require 'bigdecimal'

<<<<<<< HEAD:1.8/library/bigdecimal/shared/to_int.rb
shared :bigdecimal_to_int  do |cmd|

  describe "BigDecimal##{cmd}" do

    it "returns nil if BigDecimal is infinity or NaN" do
      BigDecimal("Infinity").send(cmd).should == nil
      BigDecimal("NaN").send(cmd).should == nil
    end

    it "returns Integer or Bignum otherwise" do
      BigDecimal("3E-20001").send(cmd).should == 0
      BigDecimal("2E4000").send(cmd).should == 2 * 10 ** 4000
      BigDecimal("2").send(cmd).should == 2
      BigDecimal("2E10").send(cmd).should == 20000000000
      BigDecimal("3.14159").send(cmd).should == 3
      BigDecimal("-3E-20001").send(cmd).should == 0
      BigDecimal("-2E4000").send(cmd).should == -2 * 10 ** 4000
      BigDecimal("-2").send(cmd).should == -2
      BigDecimal("-2E10").send(cmd).should == -20000000000
      BigDecimal("-3.14159").send(cmd).should == -3
    end
=======
describe :bigdecimal_to_int , :shared => true do
  it "returns nil if BigDecimal is infinity or NaN" do
    BigDecimal("Infinity").send(@method).should == nil
    BigDecimal("NaN").send(@method).should == nil
>>>>>>> 7b9bd5fb76f5b785608d997d6971055af84059cf:1.8/library/bigdecimal/shared/to_int.rb
  end

  it "returns Integer or Bignum otherwise" do
    BigDecimal("3E-20001").send(@method).should == 0
    BigDecimal("2E4000").send(@method).should == 2 * 10 ** 4000
    BigDecimal("2").send(@method).should == 2
    BigDecimal("2E10").send(@method).should == 20000000000
    BigDecimal("3.14159").send(@method).should == 3
  end
end
