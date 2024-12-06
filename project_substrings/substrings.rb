def substrings(substr, dictionary)
  result = {}
  substr.downcase.split(" ").each do |item|
    dictionary.each do |word|
      result[word] = (result[word] || 0 ) + 1 if item.include?(word)
    end
  end
  result
end

puts substrings("Howdy partner, sit down! How's it going?",  ["below", "down", "go", "going", "horn", "how", "howdy", "it", "i", "low", "own", "part", "partner", "sit"])