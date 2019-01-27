class Player
  attr_reader :player1, :player2, :player1_symbol, :player2_symbol, :current_player, :current_symbol
  def initialize
    @player1 = "Player 1"
    @player2 = "Player 2"
    @player1_symbol = "●"
    @player2_symbol = "○"
    @current_player = @player1
    @current_symbol = @player1_symbol
  end

  def change_current_player
    # uses ternary operators to assign current_player and current_symbol based on what they are at the time
    @current_player = (@current_player == @player1) ? @player2 : @player1
    @current_symbol = (@current_symbol == @player1_symbol) ? @player2_symbol : @player1_symbol
  end
end
