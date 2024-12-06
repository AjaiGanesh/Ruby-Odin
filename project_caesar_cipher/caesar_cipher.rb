def caesar_cipher(string, position)
  position %= 26
  result = ""
  string.each_char do |letter|
    if letter =~ /[A-Za-z]/
      base = letter.ord < 91 ? 65 : 97
      result << (((letter.ord - base + position) % 26) + base).chr
    else
      result << letter
    end
  end
  result
end

puts caesar_cipher("Hello World!", 5)