require 'yaml'

class Solution
  attr_accessor :word, :word_array, :hidden_array
  def initialize
    @word = random_word.downcase.strip
    @word_array = @word.split('')
    @hidden_array = create_hidden_array
  end

  def random_word
    words = File.readlines("5desk.txt")
    words[rand(1..words.size)]
  end

  def create_hidden_array
    arr = []
    @word.length.times do |i|
      arr.push("_")
    end
    return arr
  end
end

class Game
  def initialize
    @playing = true
    ask_game
    run_game
  end

  def ask_game
    Dir.mkdir('tmp') unless Dir.exist?('tmp')
    if File.exist?('./tmp/game_save.yaml')
      puts "Would you like to load a previously saved game? (Y/n)"
      input = gets.chomp.downcase
      if input == "y"
        puts "Found saved game. Resuming..."
        load_game
      else
        new_game
      end
    else
      new_game
    end
  end

  def new_game
    @solution = Solution.new
    @turns = 7
    @used_letters = []
  end

  def load_game
    Dir.chdir('tmp')
    data = YAML::load_file('game_save.yaml')
    @solution = data[:solution]
    @turns = data[:turns]
    @used_letters = data[:used_letters]
    Dir.chdir('../')
  end

  def run_game
    while @playing == true
      turn
    end
  end

  def turn
    show_game_status
    input = get_input
    puts
    stop_game("pause") if input == "pause"
    check_solution(input)
    @used_letters.push(input)
    @turns -= 1
    stop_game("lose") if @turns == 0
  end

  def get_input
    input = ''
    until verify_input(input)
      print "Enter a letter: "
      input = gets.chomp.downcase
    end
    return input
  end

  def verify_input(i)
    return true if i == "pause"
    return false if i.length != 1
    return false if i[/[a-z]/] != i
    return false if @used_letters.include?(i)
    return true
  end

  def check_solution(input)
    if @solution.word_array.include?(input)
      @solution.word_array.each_with_index do |letter,index|
        @solution.hidden_array[index] = input if input == letter
      end
      stop_game("win") if @solution.word == @solution.hidden_array.join('')
      @turns += 1
    end
  end

  def show_game_status
    puts "You have #{@turns} strikes left."
    puts "You have used the letters:"
    puts @used_letters.sort.join(", ")
    puts @solution.hidden_array.join(" ")
  end

  def pause_game
    data = {
      :solution => @solution,
      :turns => @turns,
      :used_letters => @used_letters
    }
    Dir.mkdir('tmp') unless Dir.exist?('tmp')
    Dir.chdir('tmp')
    puts "Are you sure? This will overwrite any previous saved games (Y/n)?"
    input = gets.chomp.downcase
    File.open('game_save.yaml', 'w') { |f| YAML::dump(data, f) } if input == "y"
  end

  def stop_game(value)
    if value == "pause"
      pause_game
    elsif value == "win"
      puts "You win! You guessed the word '#{@solution.word}' and had #{@turns} strikes remaining!"
      File.delete('./tmp/game_save.yaml') if File.exist?('./tmp/game_save.yaml')
    elsif value == "lose"
      puts "You lose. Out of guesses."
      puts "The word was #{@solution.word}."
      File.delete('./tmp/game_save.yaml') if File.exist?('./tmp/game_save.yaml')
    end
    @playing = false
  end
end

Game.new
