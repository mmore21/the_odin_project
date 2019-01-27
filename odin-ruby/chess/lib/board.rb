require_relative 'piece'
require_relative 'restrictions'
include Piece
include Restrictions

class Board
  attr_accessor :cells
  attr_reader :check, :checkmate

  class Cell
    attr_accessor :occupant, :symbol, :coordinate
    def initialize(coordinate, occupant = nil, symbol = " ")
      @coordinate = coordinate
      @occupant = occupant
      @symbol = symbol
    end
  end

  def initialize
    @cells = []
    @check = false
    @checkmate = false
    create
  end

  # creates a 64-sized array (to store board pieces)
  def create
    (1..8).each do |v|
      (1..8).each do |h|
        @cells << Cell.new([h, v])
      end
    end
  end

  # pieces are created with index, so this changes it to coordinate to keep code DRY in the possible_moves methods
  def index_to_coordinate(index)
    coordinate = @cells[index].coordinate
  end

  # blueprint for setting pieces onto board
  def set_pieces(indexes, piece, player)
    indexes.each do |i|
      @cells[i].occupant = determine_piece(piece, player, index_to_coordinate(i))
      @cells[i].symbol = @cells[i].occupant.symbol[player.number]
    end
  end

  def check_pawn_promotion(origin, target, current_player)
    if origin.occupant.class == Pawn
      origin.occupant.initial = false if origin.occupant.initial == true
      promoted_piece = origin.occupant.check_promote
      unless promoted_piece == false
        target.occupant = promoted_piece
        target.symbol = promoted_piece.symbol[current_player.number]
      end
    end
  end

  def move_piece(current_player, escape_moves)
    valid = false
    until valid
      if current_player.name == "Computer"
        random_piece = @cells.select{ |c| c.occupant != nil && c.occupant.player == current_player }.sample
        origin_coord = random_piece.coordinate
        target_coord = random_piece.occupant.possible_moves(origin_coord).sample
      else
        origin_coord = get_origin_input
        return "pause" if origin_coord == "pause"
        target_coord = get_target_input
        return "pause" if target_coord == "pause"
      end
      origin = (@cells.select { |c| c.coordinate == origin_coord }).first
      target = (@cells.select { |c| c.coordinate == target_coord }).first
      if @check == true
        valid = true if escape_moves.any?{ |a| a == [origin,target] }
      else
        valid = true if validate_move(origin, target, current_player) == true && prevent_move_check(origin, target, current_player) == false
      end
    end
    @check = false
    target.occupant = origin.occupant
    target.symbol = origin.occupant.symbol[current_player.number]
    target.occupant.current_coord = target.coordinate
    check_pawn_promotion(origin, target, current_player)
    # erases the origin cell now that there is no piece in it
    origin.occupant = nil
    origin.symbol = " "
  end

  def validate_move(origin, target, current_player)
    # if the player tries to move a piece from a cell that is empty
    return false if origin.occupant == nil
    # if a player tries to move his opponent's pieces
    return false if origin.occupant.player != current_player
    # if the player tries to knock out one of his own pieces
    return false if target.occupant != nil && origin.occupant.player == target.occupant.player
    # gets possible moves depending on piece selected
    possible = origin.occupant.possible_moves(origin.coordinate)
    # prevents pawn from vertically knocking out an opponent's piece and adds ability to move diagonally
    possible_pawn_moves = special_pawn_move(origin, target, cells)
    return false if possible_pawn_moves == false
    possible.push(possible_pawn_moves.flatten)
    # if the target is not in possible moves
    return false if possible.include?(target.coordinate) == false
    # does not allow rook or queen to jump over other pieces
    return false if validate_straight_slide(origin, target, cells) == false
    # does not allow bishop or queen to jump over other pieces
    return false if validate_diagonal_slide(origin, target, cells) == false
    #return false if prevent_move_check(origin, target, current_player) == true
    true
  end

  def prevent_move_check(origin, target, current_player)
    enemy_pieces = @cells.select{ |c| c.occupant != nil && c.occupant.player != current_player}
    if origin.occupant.class == King
      enemy_pieces.each do |piece|
        return true if validate_move(piece, target, piece.occupant.player) == true
      end
    else
      king = (@cells.select{ |c| c.occupant != nil && c.occupant.class == King && c.occupant.player == current_player }).first
      enemy_pieces.each do |piece|
        temp_target = target.occupant
        target.occupant = origin.occupant
        target.occupant.current_coord = target.coordinate
        origin.occupant = nil
        if validate_move(piece, king, piece.occupant.player)
          origin.occupant = target.occupant
          origin.occupant.current_coord = origin.coordinate
          target.occupant = temp_target
          return true
        end
        origin.occupant = target.occupant
        origin.occupant.current_coord = origin.coordinate
        target.occupant = temp_target
      end
    end
    false
  end


  def find_check_pieces(current_player, enemy_king, exclude_piece = nil)
    pieces = @cells.select{ |c| c.occupant != nil && c.occupant.player == current_player }
    check_pieces = []
    pieces.each do |piece|
      if validate_move(piece, enemy_king, current_player)
        check_pieces << piece
      end
    end
    if exclude_piece != nil
      check_pieces.delete(exclude_piece)
    end
    return check_pieces
  end

  def check(current_player)
    enemy_king = (@cells.select{ |c| c.occupant.class == King && c.occupant.player != current_player }).first
    enemy_pieces = @cells.select{ |c| c.occupant != nil && c.occupant.player != current_player }
    check_pieces = find_check_pieces(current_player, enemy_king)
    escape_moves = []
    if !check_pieces.empty?
      @check = true
      puts "Check"
      # if a king's piece or king can take out the piece that put king in check
      if check_pieces.size == 1
        enemy_pieces.each do |piece|
          if validate_move(piece, check_pieces[0], piece.occupant.player)
            escape_moves << [piece, check_pieces[0]]
          end
        end
      end
      # if the king can escape or take out whomever checked it
      enemy_king_moves = enemy_king.occupant.possible_moves(enemy_king.coordinate)
      enemy_king_moves.each do |move|
        current_cell = (@cells.select{ |c| c.coordinate == move }).first
        if validate_move(enemy_king, current_cell, enemy_king.occupant.player) == true && find_check_pieces(current_player, enemy_king, current_cell).empty?
          escape_moves << [enemy_king, current_cell]
        end
      end
      if escape_moves.empty?
        @checkmate = true
        puts "Checkmate"
      end
    end
    return escape_moves
  end

  def show
    a= []
    @cells.each { |cell| a << cell.symbol }
    puts "  ┌───┬───┬───┬───┬───┬───┬───┬───┐"
    puts "8 │ #{a[56]} │ #{a[57]} │ #{a[58]} │ #{a[59]} │ #{a[60]} │ #{a[61]} │ #{a[62]} │ #{a[63]} │"
    puts "  ├───┼───┼───┼───┼───┼───┼───┼───┤"
    puts "7 │ #{a[48]} │ #{a[49]} │ #{a[50]} │ #{a[51]} │ #{a[52]} │ #{a[53]} │ #{a[54]} │ #{a[55]} │"
    puts "  ├───┼───┼───┼───┼───┼───┼───┼───┤"
    puts "6 │ #{a[40]} │ #{a[41]} │ #{a[42]} │ #{a[43]} │ #{a[44]} │ #{a[45]} │ #{a[46]} │ #{a[47]} │"
    puts "  ├───┼───┼───┼───┼───┼───┼───┼───┤"
    puts "5 │ #{a[32]} │ #{a[33]} │ #{a[34]} │ #{a[35]} │ #{a[36]} │ #{a[37]} │ #{a[38]} │ #{a[39]} │"
    puts "  ├───┼───┼───┼───┼───┼───┼───┼───┤"
    puts "4 │ #{a[24]} │ #{a[25]} │ #{a[26]} │ #{a[27]} │ #{a[28]} │ #{a[29]} │ #{a[30]} │ #{a[31]} │"
    puts "  ├───┼───┼───┼───┼───┼───┼───┼───┤"
    puts "3 │ #{a[16]} │ #{a[17]} │ #{a[18]} │ #{a[19]} │ #{a[20]} │ #{a[21]} │ #{a[22]} │ #{a[23]} │"
    puts "  ├───┼───┼───┼───┼───┼───┼───┼───┤"
    puts "2 │ #{a[8]} │ #{a[9]} │ #{a[10]} │ #{a[11]} │ #{a[12]} │ #{a[13]} │ #{a[14]} │ #{a[15]} │"
    puts "  ├───┼───┼───┼───┼───┼───┼───┼───┤"
    puts "1 │ #{a[0]} │ #{a[1]} │ #{a[2]} │ #{a[3]} │ #{a[4]} │ #{a[5]} │ #{a[6]} │ #{a[7]} │"
    puts "  └───┴───┴───┴───┴───┴───┴───┴───┘"
    puts "    a   b   c   d   e   f   g   h"
  end
end
