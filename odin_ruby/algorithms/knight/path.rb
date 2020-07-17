class Move
  attr_accessor :next, :previous
  attr_reader :point

  def initialize(point)
    @point = point
    @next = nil
    @previous = nil
  end
end

class Board
  attr_reader :cells

  def initialize
    create
  end

  def create
   @cells = [
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
end


class Knight
  def initialize
    @board = Board.new.cells
  end

  def move(start, target)
    start_position = Move.new(start)
    puts "hi"
    end_position = find_route(start_position, target)
    puts "hii"
    path = trace(end_position)
    puts "hiii"
    puts "You made it in #{route.size - 1} moves! Here's your path:"
    print_path
  end

  def possible_moves(start)
    x, y = start
    moves = [
      [x - 2, y + 1], [x - 1, y + 2], [x + 1, y + 2], [x + 2, y + 1],
      [x - 2, y - 1], [x - 1, y - 2], [x + 1, y - 2], [x + 2, y - 1]
    ]
    moves.delete_if { |move| !@board.include?(move) }
    moves
  end

  def find_route(move, target)
    current = move
    queue = []
    loop do
      possible = possible_moves(move.point)
      possible.each do |p|
        move = Move.new(p)
        move.previous = current
        current.next = move
        return move if move.point == target
        queue << move
      end
      current = queue.shift
    end
  end

  def print_path(path)
    path.each { |move| p move }
  end

  def trace(end_position)
    path = [end_position.point]
    current = end_position
    until current.previous.nil?
      path << current.previous.point
      current = current.previous
    end
    path
  end
end


knight = Knight.new
knight.move([1,2], [3,4])
