require_relative 'grid'
require_relative 'player'

class Game
  attr_reader :players, :grid
  def initialize
    @players = Player.new
    @grid = Grid.new
  end

  def start
    game_over = false
    @grid.show
    until game_over == true
      move = make_move
      @grid.show
      game_over = @grid.check_if_won(@players)
      if @grid.grid_array.all? { |cell| cell.used != nil }
        puts "It's a scratch."
        game_over = true
      end
      @players.change_current_player
    end
  end

  def make_move
    puts "#{@players.current_player}'s turn - #{@players.current_symbol}"
    print "Select a column: "
    input = gets.chomp.to_i

    until @grid.horizontal.include?(input) && (@grid.grid_array.select { |cell| cell.row == input && cell.used.nil? }).size != 0
      puts "#{@players.current_player}'s turn - #{@players.current_symbol}"
      print "Select a column: "
      input = gets.chomp.to_i
    end

    current_column = @grid.grid_array.select { |cell| cell.row == input && cell.used.nil? }
    cell = current_column.min_by { |cell| cell.column }
    cell.used = @players.current_symbol
  end
end

game = Game.new
game.start
