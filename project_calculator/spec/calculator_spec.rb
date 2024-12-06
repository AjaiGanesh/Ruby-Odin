require_relative "../lib/calculator"

describe Calculator do
  describe "add two numbers" do
    it 'return the sum of two numbers' do
      calculator = Calculator.new
      expect(calculator.add(2, 3)).to eql(5) 
    end
    it "returns the sum of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end

  describe "sub two numbers" do
    it 'returns the subtraction of two numbers' do
      calculator = Calculator.new
      expect(calculator.sub(5, 2)).to  eql(3)
    end
  end
  
  describe "multiple of two numbers" do
    it 'returns the subtraction of two numbers' do
      calculator = Calculator.new
      expect(calculator.mul(5, 2)).to  eql(10)
    end
  end

  describe "sub two numbers" do
    it 'returns the subtraction of two numbers' do
      calculator = Calculator.new
      expect(calculator.div(5, 2)).to  eql(2)
    end
  end

end
