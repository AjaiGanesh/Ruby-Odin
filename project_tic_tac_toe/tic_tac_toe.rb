class Game
  def initialize
    @board = Array.new(9, " ")
    @current_player = ["X", "O"].sample
  end

  def display_board
    str = ""
    @board.each_with_index do |item, index|
      if index == (@board.length - 1)
        str.concat(item)
      elsif [2,5].include?(index)
        str.concat("#{item}\n--+---+--\n")
      else
        str.concat("#{item} | ")
      end
    end
    puts str
  end

  def switch_player
    @current_player = @current_player == "X" ? "O" : "X"
  end

  def make_a_move
    loop do 
      puts "Enter your position below"
      input = gets.chomp.to_i
      if @board[input - 1] == " "
        @board[input - 1] = @current_player 
        break
      else
        puts "Invalid move please try again"
      end
    end
  end

  def winner?
    lines = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    lines.any? { |line| line.all? {|element| @board[element] == @current_player}}
  end

  def play
    loop do
      display_board
      make_a_move

      if winner?
        display_board
        puts "The winner is #{@current_player}"
        break
      elsif !@board.include?(" ")
        display_board
        p "It is a Draw!"
        break
      else
        switch_player
      end
    end
  end
end

tic_tac_toe = Game.new
puts tic_tac_toe.play