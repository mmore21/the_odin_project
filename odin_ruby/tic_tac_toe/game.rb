class Grid
  attr_accessor :grid_array, :boxes_left
  def initialize(player)
    @grid_array = (1..9).map { |n| n.to_s }
    @boxes_left = @grid_array.length
    @player = player
  end

  def show
    puts " #{@grid_array[0]} | #{@grid_array[1]} | #{@grid_array[2]} "
    puts "-----------"
    puts " #{@grid_array[3]} | #{@grid_array[4]} | #{@grid_array[5]} "
    puts "-----------"
    puts " #{@grid_array[6]} | #{@grid_array[7]} | #{@grid_array[8]} "
  end

  def move(input)
    @grid_array[input.to_i - 1] = @player.current_symbol
    @boxes_left -= 1
  end

  def check_if_won
    a = @grid_array
    solutions = [
                    [a[0], a[1], a[2]],
                    [a[3], a[4], a[5]],
                    [a[6], a[7], a[8]],
                    [a[0], a[3], a[6]],
                    [a[1], a[4], a[7]],
                    [a[2], a[5], a[8]],
                    [a[0], a[4], a[8]],
                    [a[2], a[4], a[6]]
                   ]
    if solutions.any? { |array| array.uniq.count == 1 }
      puts "#{@player.current_player} wins."
      return false
    elsif @boxes_left == 0
      puts "It's a scratch!"
      return false
    end
    return true
  end
end


class Player
  attr_accessor :current_player, :current_symbol, :p1symbol
  def initialize
    @player1 = "Player 1"
    @player2 = "Player 2"
    @p1symbol = "X"
    @p2symbol = "O"
    @current_symbol = @p1symbol
    @current_player = @player1
  end
  
  def change_player
    if @current_player == @player1
      @current_player = @player2
      @current_symbol = @p2symbol
    elsif @current_player == @player2
      @current_player = @player1
      @current_symbol = @p1symbol
    end
  end
end

module Messages
  def intro_message
    puts "Welcome to Tic-Tac-Toe"
    help_message
  end
  
  def help_message
    puts
    puts "To make your move, type the number corresponding to the box."
    puts "To restart the game, type 'restart'."
    puts "To exit the game, type 'exit'."
    puts "To view this help dialouge again, type 'help'."
    puts
  end
  
  def restart_message
    puts
    puts "Game has been reset."
    puts
  end
  
  def exit_message
    puts
    puts "Thanks for playing."
  end
  
  def invalid_message
    puts
    puts "Invalid command. Type 'help' for help."
    puts
  end
end

################################################################################

include Messages
playing = true
player = Player.new
grid = Grid.new(player)
intro_message
while playing == true
    print "#{player.current_player}'s turn:"
    input = gets.chomp.to_s
    if input == "exit"
      exit_message
      playing = false
    elsif input == "restart"
      player = Player.new
      grid = Grid.new(player)
      restart_message
    elsif input == "help"
      help_message
    elsif grid.grid_array.include?(input)
      grid.move(input)
      puts
      grid.show
      puts
      playing = grid.check_if_won
      player.change_player
    else
      invalid_message
    end
end