class Game
  COLORS = %w[red blue green yellow black white]

  def initialize
    @secret_code = COLORS.sample(4)
    @attempts = 0
    @max_no_of_attempts = 10
  end

  def play
    puts "Try guess the secret code; Colours available to guess are #{COLORS.join(" ")}"
    loop do
      guess = get_guess
      exact_matches, color_matches = feedback(guess)
      @attempts += 1
      if exact_matches == 4
        puts "Booyah! You have cracked the secret code in #{@attempts} attempts"
        break
      elsif @max_no_of_attempts >= @attempts
        puts "You have execeed the maximum no of attempts(#{@max_no_of_attempts}); Try again next time"
        break
      else
        puts "Exact matches (correct color and position) = #{exact_matches}"
        puts "Color matches (correct color and wrong position) = #{color_matches}"
        puts "You have #{@max_no_of_attempts - @attempts} attempts remaining."
      end

    end
  end

  def get_guess
    loop do
      puts "Please enter your guess with four values with space seperated"
      input = gets.chomp.to_s.downcase.split(" ")
      if input.length == 4 && input.all? { |element| COLORS.include?(element)}
        return input
      else
        puts "Invalid input please try again"
      end
    end
  end

  def feedback(guess)
    exact_matches = 0
    color_matches = 0
    secret_code_copy = @secret_code.dup

    guess.each_with_index do |item, index|
      if item == @secret_code[index]
        exact_matches +=1
        secret_code_copy[index] = nil
      end
    end

    guess.each_with_index do |item, index|
      if item != @secret_code[index] && @secret_code.include?(item)
        color_matches += 1
        secret_code_copy[secret_code_copy.index(item)] = nil
      end
    end

    [exact_matches, color_matches]

  end

end

mastermind = Game.new
mastermind.play