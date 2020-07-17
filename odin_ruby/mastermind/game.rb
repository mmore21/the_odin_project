module GameFlow
  def get_input
    input = ''
    while input.length != 4
      puts "Enter a 4 digit number."
      begin
        input = Integer(gets.chomp).to_s
        array = input.split('')
        if array.any? { |x| x.to_i > 6 || x.to_i < 1}
          puts "Only use digits 1-6."
          redo
        end
        rescue ArgumentError
          puts "That's not a number."
          puts "Enter 4 Digit Number."
        retry
      end
    end
    return input
  end
  
  def random_number
    number = ''
    4.times do
      number += rand(1..6).to_s
    end
    return number
  end
end

class Solution
  attr_accessor :number
  include GameFlow
  def initialize(mode)
    @mode = mode
    create_solution
  end
  
  def create_solution
    if @mode == "human"
      create_human_solution
    elsif @mode == "random"
      create_random_solution
    end
  end
  
  def create_human_solution
    number = get_input
    @number = number
    puts "Solution created."
  end
  
  def create_random_solution
    @number = random_number
    puts "Solution created."
  end
  
  def check_if_matching(num)
    if num == @number
      return true
    else
      return false
    end
  end
end

class Game
  attr_accessor :solution
  include GameFlow
  def initialize
    @turns = 1
    @mode = choose_game
    setup_game
  end
  
  def choose_game
    input = ''
    until input == "human" || input == "random"
      puts "Enter 'random' to have the computer create a solution for you to guess."
      puts "Or enter 'human' to generate your own solution for the computer to try to guess!"
      input = gets.chomp
    end
    return input
  end
  
  def setup_game
    if @mode == "random"
      @human = Human.new
      @solution = Solution.new(@mode)
      run_game(@human)
    elsif @mode == "human"
      @solution = Solution.new(@mode)
      puts "Choose difficulty for the AI"
      puts "| Stupid | Smart | Perfect |"
      input = gets.chomp
      @ai = AI.new(input)
      @ai.get_solution(@solution.number) if input == "Perfect"
      run_game(@ai)
    end
  end
  
  def run_game(user)
    game_over = false
    until game_over == true
      if @turns == 12
        puts "You are on turn #{@turns} (#{13-@turns} guess left)."
      else
        puts "You are on turn #{@turns} (#{13-@turns} guesses left)."
      end
      # depending on whether @human or @ai was passed into here, run that class instance's guess function accordingly
      number = user.guess
      if @solution.check_if_matching(number)
        if user == @human
          puts "Correct! The number was #{@solution.number}."
          puts "You won on turn #{@turns}!"
        elsif user == @ai
          puts "You lose. The AI guessed your number."
        end
        game_over = true
      elsif @turns == 12
        if user == @human
          puts "You lose. Out of turns."
          puts "Number was #{@solution.number}."
        elsif user == @ai
          puts "You win. The AI ran out of turns."
        end
        game_over = true
      else
        hints = create_hints(number)
        @ai.give_hints(hints) if user == @ai
      end
      @turns += 1
    end
  end
  
  def create_hints(number)
    number_array = number.split('')
    solution_array = @solution.number.split('')
    occurences_hash = Hash.new()
    solution_array.each do |val|
      occurences_hash[val] = solution_array.count(val)
    end
    occurences = 0
    matches = 0
    number_array.each do |num|
      if occurences_hash.has_key?(num)
        occurences += 1
        occurences_hash[num] -= 1
        occurences_hash.each do |key, val|
          occurences_hash.delete_if { |key, val| val == 0 }
        end
      end
    end
    number_array.each_with_index do |num, index|
      if number_array[index] == solution_array[index]
        matches += 1
      end
    end
    puts "Occurences (out of order): #{occurences}"
    puts "Matches (in order): #{matches}"
    puts
    return occurences
  end
end

class Human
  include GameFlow
  
  def guess
    return get_input
  end
  
end

class AI
  include GameFlow
  def initialize(difficulty)
    @difficulty = difficulty
    @hint_hash = Hash.new(0)
    @@count = 0
    @guesses = []
  end
  
  def guess
    if @difficulty == "Stupid"
      guess_stupid
    elsif @difficulty == "Smart"
      @hints = guess_smart
    elsif @difficulty == "Perfect"
      guess_perfect
    end
  end
  
  def guess_stupid
    random = random_number
    puts random
    return random
  end
  
  def guess_smart
    @@count += 1
    if @@count <= 6
      number = "11" + (@@count.to_s * 2)
      puts "Bot guesses #{number}."
      return number
    else
      number_array = []
      @hint_hash.each do |k,v|
        v.to_i.times do |x|
          number_array.push(k)
        end
      end
      number = number_array.shuffle.join
      while @guesses.include?(number)
        number = number_array.shuffle.join
      end
      @guesses.push(number)
      puts "Bot guesses #{number}."
      return number
    end
  end
  
  def guess_perfect
    puts "Bot guesses #{@solution}."
    return @solution
  end
  
  def give_hints(info)
    occurences = info
    if @@count == 1
      @one_occurences = occurences
      @hint_hash["#{@@count}"] = @one_occurences
      @one_occurences -= 1 if @one_occurences == 3
    elsif @@count <= 6
      @hint_hash["#{@@count}"] = (occurences.to_i - @one_occurences.to_i)
    end
    if @@count >= 6
      @hint_hash.delete_if { |key, value| value == 0 }
      if @hint_hash.length == 2
        num = @hint_hash[@hint_hash.key(2)] + 1
        @hint_hash[@hint_hash.key(2)] = num
      elsif @hint_hash.length == 1
        num = @hint_hash[@hint_hash.key(2)] + 2
        @hint_hash[@hint_hash.key(2)] = num
      end
    end
  end
  
  def get_solution(solution)
    @solution = solution
  end
end

######################################################################################################
# game is complete and fully functional; refactoring can be done on some of the main / bulky functions
######################################################################################################

Game.new