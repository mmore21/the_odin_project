require_relative 'restrictions'
include Restrictions

module Piece

  def determine_piece(name, player, coordinate)
    return case name
    when "pawn" then Pawn.new(player, coordinate)
    when "knight" then Knight.new(player, coordinate)
    when "bishop" then Bishop.new(player, coordinate)
    when "rook" then Rook.new(player, coordinate)
    when "queen" then Queen.new(player, coordinate)
    when "king" then King.new(player, coordinate)
    end
  end

  class Pawn
    attr_accessor :current_coord, :initial
    attr_reader :symbol, :player
    def initialize(player, current_coord)
      @symbol = ['♙','♟']
      @player = player
      @current_coord = current_coord
      @initial = true
    end

    def check_promote
      return create_promote(@player, @current_coord) if @player.number == 0 && @current_coord[1] == 8
      return create_promote(@player, @current_coord) if @player.number == 1 && @current_coord[1] == 1
      false
    end

    def create_promote(player, coordinate)
      name = get_promotion_piece_name
      determine_piece(name, player, coordinate)
    end

    def possible_moves(coordinate)
      possible = []
      [@current_coord].each do |h,v|
        if @player.number == 0
          possible << [h, v+2] if @initial
          possible << [h, v+1]
        elsif @player.number == 1
          possible << [h, v-2] if @initial
          possible << [h, v-1]
        end
      end
      moves_inside_board(possible)
    end
  end

  class Knight
    attr_accessor :current_coord
    attr_reader :symbol, :player
    def initialize(player, current_coord)
      @symbol = ['♘','♞']
      @player = player
      @current_coord = current_coord
    end

    def possible_moves(coordinate)
      possible = []
      [@current_coord].each do |h,v|
        possible.push([h+1, v+2], [h+1, v-2], [h-1, v+2], [h-1, v-2], [h+2, v+1], [h+2, v-1], [h-2, v+1], [h-2, v-1])
      end
      moves_inside_board(possible)
    end
  end

  class Bishop
    attr_accessor :current_coord
    attr_reader :symbol, :player
    def initialize(player, current_coord)
      @symbol = ['♗','♝']
      @player = player
      @current_coord = current_coord
    end

    def possible_moves(coordinate)
      possible = []
      [@current_coord].each do |h,v|
        1.upto(8) do |n|
          possible.push([h+n, v+n], [h+n, v-n], [h-n, v+n], [h-n, v-n])
        end
      end
      moves_inside_board(possible)
    end

  end

  class Rook
    attr_accessor :current_coord
    attr_reader :symbol, :player
    def initialize(player, current_coord)
      @symbol = ['♖','♜']
      @player = player
      @current_coord = current_coord
    end

    def possible_moves(coordinate)
      possible = []
      [@current_coord].each do |h,v|
        1.upto(8) do |n|
          possible.push([h+n, v], [h-n, v], [h, v+n], [h, v-n])
        end
      end
      moves_inside_board(possible)
    end
  end

  class Queen
    attr_accessor :current_coord
    attr_reader :symbol, :player
    def initialize(player, current_coord)
      @symbol = ['♕','♛']
      @player = player
      @current_coord = current_coord
    end

    def possible_moves(coordinate)
      possible = []
      [@current_coord].each do |h,v|
        1.upto(8) do |n|
          possible.push([h+n, v], [h-n, v], [h, v+n], [h, v-n], [h+n, v+n], [h+n, v-n], [h-n, v+n], [h-n, v-n])
        end
      end
      moves_inside_board(possible)
    end
  end

  class King
    attr_accessor :current_coord
    attr_reader :symbol, :player
    def initialize(player, current_coord)
      @symbol = ['♔','♚']
      @player = player
      @current_coord = current_coord
    end

    def possible_moves(coordinate)
      possible = []
      [@current_coord].each do |h,v|
        possible.push([h+1, v+1], [h+1, v-1], [h-1, v+1], [h-1,v-1], [h+1, v], [h-1, v], [h, v+1], [h, v-1])
      end
      moves_inside_board(possible)
    end
  end
end
