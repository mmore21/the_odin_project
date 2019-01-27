require 'yaml'
require_relative 'users'
require_relative 'board'
require_relative 'users'
require_relative 'piece'
require_relative 'input'
include Piece
include Input

class Game
  def initialize
    @users = Users.new
    @board = Board.new
    start_game
    run_game
  end

  def start_game
    if File.exist?('./tmp/game_save.yaml')
      puts "Would you like to resume your game?"
      puts "This will remove any previously saved games? (Y/n)"
      input = gets.chomp.downcase
      if input == "y" || input == ""
        resume_game
      else
        new_game
      end
    else
      new_game
    end
  end

  def pause_game
    data = {
      :users => @users,
      :board => @board
    }
    Dir.mkdir('tmp') unless Dir.exist?('tmp')
    Dir.chdir('tmp')
    File.open('game_save.yaml', 'w') { |f| YAML::dump(data, f) }
    puts "Game saved successfully."
  end

  def resume_game
    Dir.chdir('tmp')
    data = YAML::load_file('game_save.yaml')
    @users = data[:users]
    @board = data[:board]
    File.delete('game_save.yaml')
    Dir.chdir('../')
    Dir.delete('tmp')
    @board.show
  end

  def new_game
    mode = get_game_mode
    @users.create_second_player(mode)

    @board.set_pieces([8,9,10,11,12,13,14,15], "pawn", @users.player1)
    @board.set_pieces([1,6], "knight", @users.player1)
    @board.set_pieces([0,7], "rook", @users.player1)
    @board.set_pieces([2,5], "bishop", @users.player1)
    @board.set_pieces([3], "king", @users.player1)
    @board.set_pieces([4], "queen", @users.player1)
    @board.set_pieces([48,49,50,51,52,53,54,55], "pawn", @users.player2)
    @board.set_pieces([57,62], "knight", @users.player2)
    @board.set_pieces([56,63], "rook", @users.player2)
    @board.set_pieces([58,61], "bishop", @users.player2)
    @board.set_pieces([59], "king", @users.player2)
    @board.set_pieces([60], "queen", @users.player2)
    @board.show
  end

  def run_game
    escape_moves = []
    while @board.checkmate == false
      pause = move(escape_moves)
      return nil if pause == "pause"
      escape_moves = @board.check(@users.current_player)
      puts "#{@users.current_player.name} wins!" if @board.checkmate == true
      @users.change_player
    end
  end

  def move(escape_moves)
    puts "#{@users.current_player.name}'s turn:"
    current_move = @board.move_piece(@users.current_player, escape_moves)
    if current_move == "pause"
      pause_game
      return "pause"
    end
    @board.show
  end

end
