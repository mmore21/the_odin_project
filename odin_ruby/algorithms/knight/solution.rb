class Move
  attr_accessor :coordinates, :next_move, :prev_pos

  def initialize(coordinates)
    @coordinates = coordinates
    @prev_pos = nil
    @next_move = nil
  end
end

# Represents a knight piece that can move from one cell to another
class Knight
  def initialize
    @board_cells = [
      [1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7], [1, 8],
      [2, 1], [2, 2], [2, 3], [2, 4], [2, 5], [2, 6], [2, 7], [2, 8],
      [3, 1], [3, 2], [3, 3], [3, 4], [3, 5], [3, 6], [3, 7], [3, 8],
      [4, 1], [4, 2], [4, 3], [4, 4], [4, 5], [4, 6], [4, 7], [4, 8],
      [5, 1], [5, 2], [5, 3], [5, 4], [5, 5], [5, 6], [5, 7], [5, 8],
      [6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7], [6, 8],
      [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7], [7, 8],
      [8, 1], [8, 2], [8, 3], [8, 4], [8, 5], [8, 6], [8, 7], [8, 8]
    ]
  end

  def knight_moves(start, target)
    start_pos = Move.new(start)
    end_pos = find_route(start_pos, target)
    route = trace_route(end_pos).reverse
    puts "You made it in #{route.size - 1} moves! Here's your route:"
    print_route(route)
  end

  private

  def possible_moves(start)
    x, y = start
    moves = [
      [x - 2, y + 1], [x - 1, y + 2], [x + 1, y + 2], [x + 2, y + 1],
      [x - 2, y - 1], [x - 1, y - 2], [x + 1, y - 2], [x + 2, y - 1]
    ]
    moves.delete_if { |move| !@board_cells.include?(move) }
    moves
  end

  def find_route(start_pos, target)
    current_pos = start_pos
    queue = []
    loop do
      coordinates_to_check = possible_moves(current_pos.coordinates)
      coordinates_to_check.each do |coordinates|
        move = Move.new(coordinates)
        move.prev_pos = current_pos
        current_pos.next_move = move
        return move if move.coordinates == target
        queue << move
      end
      current_pos = queue.shift
    end
  end

  def print_route(route)
    route.each { |move| p move }
  end

  def trace_route(end_pos)
    route = [end_pos.coordinates]
    current_pos = end_pos
    until current_pos.prev_pos.nil?
      route << current_pos.prev_pos.coordinates
      current_pos = current_pos.prev_pos
    end
    route
  end
end

knight = Knight.new
knight.knight_moves([3,3],[7,3])
