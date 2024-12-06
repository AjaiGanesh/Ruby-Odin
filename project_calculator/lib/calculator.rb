class Calculator
  def add(a, b, c = 0)
    a + b + c
  end

  def sub(a,b)
     a > b ? a - b : b - a
  end

  def mul(a,b)
    a * b
  end

  def div(a,b)
    a / b
  end

end
