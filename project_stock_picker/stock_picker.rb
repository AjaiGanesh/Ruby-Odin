def stock_picker(stocks)
  result = {}
  stocks.each_with_index do |stock, index|
    stocks.each_with_index do |other_stock, other_index|
      next if index >= other_index
      result[other_stock - stock] = [index, other_index] if other_stock > stock
    end
  end
  result[result.keys.max]
end

p stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])