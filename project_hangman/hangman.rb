require "yaml"
class Game
  attr_accessor :secret_key, :guesses, :key_clues, :guessed
  def initialize()
    @secret_key = generate_secret_key
    @guesses = 7
    @key_clues = ""
    @secret_key.length.times {@key_clues << "-"}
    @guessed = []
  end

  def generate_secret_key
    (File.readlines("dictionary.txt", chomp: true)).select {|line| line.length >= 5 && line.length <= 12}.sample.downcase
  end

  def game_menu
    puts "Please select one [1] for new game or [2] for save the game"
    input = nil
    loop do 
      input = gets.chomp.to_i
      break if [1,2].include?(input)
      puts "Enter the valid choice"
    end
    load_game if input == 2
    save_game if start_game == "save"
  end

  def save_game
    puts "Enter the name of the game you eant to save"
    save_name = gets.chomp.to_s.downcase
    Dir.mkdir("saved_games") unless Dir.exist?("saverd_games")
    File.open("./saved_games/#{save_name}.yml", "w") {|f| YAML.dump([] << self, f)}
    exit
    puts "File saved"
  end

  def load_game
    unless Dir.exist?("saved_games")
      puts "No saved games exists"
      return
    end
    games = saved_games
    puts games
    deserialize(load_file(games))
  end

  def saved_games
    puts 'Saved games: '
    Dir['./saved_games/*'].map { |file| file.split('/')[-1].split('.')[0] }
  end

  def load_file(games)
    loop do
      puts "Enter which saved game you want to load"
      load_file = gets.chomp
      return load_file if games.include?(load_file)
      puts "The game required doesn't exist"
    end
  end

  def deserialize(load_file)
    yaml = YAML.safe_load(File.read("./saved_games/#{load_file}.yml"), permitted_classes: [Game])
    @secret_key = yaml[0].secret_key
    @key_clues = yaml[0].key_clues
    @guesses = yaml[0].guesses
    @guessed = yaml[0].guessed
  end

  def start_game
    loop do
      if self.game_over?
        break
      else
        begin
          puts "Start Game"
          display
          puts "Enter a letter to play or Save to save the game"
          guess = gets.chomp.to_s.downcase
          return "save" if guess == "save"
          raise "Invalid input: #{guess}" unless /[[:alpha:]]/.match(guess) && guess.length == 1
          raise "You've already guessed that letter!" if @guessed.include?(guess)
          enter_guess(guess.downcase)
        rescue StandardError => e
          puts e.backtrace.join("\n")
        end
      end
    end
  end

  def game_over?
    if @secret_key == @key_clues
      puts "Hooray you have won it"
      true
    elsif @guesses == 0
      puts "Game over!!!"
      true
    end
  end

  def display
    print "Guessed letters:"
    @guessed.each {|guess| print guess+ ""}
    puts
    puts "Remaining guesses #{@guesses}"
    puts @key_clues
  end

  def enter_guess(guess)
    @guessed << guess
    if @secret_key.include?(guess)
      add_clue(guess)
      puts "Correct Guess"
    else
      @guesses -= 1
      puts "Incorrect Guess"
    end
  end

  def add_clue(guess)
    @secret_key.split("").each_with_index {|value, index| @key_clues[index] = guess if value == guess}
  end
  
end

game = Game.new
game.game_menu