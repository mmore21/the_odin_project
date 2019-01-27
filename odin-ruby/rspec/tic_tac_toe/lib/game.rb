require_relative 'messages'
require_relative 'player'
require_relative 'grid'
include Messages

class Game
  attr_reader :playing, :player, :grid
  def initialize
    @playing = true
    @player = Player.new
    @grid = Grid.new(@player)
  end

  def new_game
    intro_message
    @grid.show
    puts
    run_game
  end

  def run_game
    while @playing == true
      print "#{@player.current_player}'s turn: "
      input = gets.chomp.to_s
      if input == "exit"
        exit_message
        @playing = false
      elsif input == "restart"
        restart_game
      elsif input == "help"
        help_message
      elsif @grid.grid_array.include?(input)
        move_game(input)
      else
        invalid_message
      end
    end
  end

  def restart_game
    @player = Player.new
    @grid = Grid.new(@player)
    restart_message
    @grid.show
    puts
  end

  def move_game(input)
    @grid.move(input)
    puts
    @grid.show
    puts
    @playing = @grid.check_if_won
    @player.change_player
  end
end

# game = Game.new
# game.new_game
