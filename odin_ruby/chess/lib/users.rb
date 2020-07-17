class Users
  attr_reader :current_player, :player1, :player2

  class Player
    attr_reader :number, :name
    def initialize(number, name)
      @number = number
      @name = name
    end
  end

  def initialize
    @player1 = Player.new(0, "Player 1")
    @current_player = @player1
  end

  def create_second_player(mode)
    if mode == "1"
      @player2 = Player.new(1, "Computer")
    elsif mode == "2"
      @player2 = Player.new(1, "Player 2")
    end
  end

  def change_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end
