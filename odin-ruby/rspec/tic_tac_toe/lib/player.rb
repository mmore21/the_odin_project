class Player
  attr_accessor :current_player, :current_symbol, :player1, :player2, :p1symbol, :p2symbol
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
