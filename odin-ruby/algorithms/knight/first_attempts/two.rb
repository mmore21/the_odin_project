class Graph

  attr_reader :root

  class Node
    attr_accessor :children, :parent
    attr_reader :point
    def initialize(point, parent=nil, children=[])
      @point = point
      @parent = parent
      @children = children
    end
  end

  def initialize(root)
    @root = Node.new(root)
    @used = []
    create
  end

  private

  def get_possible_values(node)
    values = []
    [node.point].each do |x,y|
      values += [[x+2, y+1], [x+2, y-1], [x-2, y+1], [x-2, y-1], [x+1, y+2], [x+1, y-2], [x-1, y+2], [x-1, y-2]]
    end
    values.select! { |x,y| (x >= 1 && x <= 8) && (y >= 1 && y <= 8) }
    values.reject! { |a| @used.include?(a) }
    return values
  end

  def create(tier=[@root])
    tier.each do |n|
      possible = get_possible_values(n)
      return nil if possible.empty?
      possible.each do |point|
        child = Node.new(point)
        n.children << child
        child.parent = n
        @used << point unless @used.include?(point)
      end
    #  p @used
    create(n.children)
    end
  #  p @used.size
  end

end


class KnightPath
  attr_reader :graph

  def initialize(initial, target)
    @initial = initial
    @target = target
    @graph = Graph.new(initial)
  end

  def graph_bfs(node = @graph.root)
    queue = [node]
    while !queue.empty?
      current = queue.shift
      if current.point == @target
        array = get_parent_path(current)
        puts "You made it in #{array.length} moves! Here's your path:"
        array.each { |a| p a }
        return array
      end
      queue += current.children
    end
    return nil
  end

  def get_parent_path(node, a = [@target])
    return a.reverse if node.parent.nil?
    a.push(node.parent.point)
    get_parent_path(node.parent, a)
  end

end

knight = KnightPath.new([3, 3], [8,6])
knight.graph_bfs

knight = KnightPath.new([7, 4], [8,6])
knight.graph_bfs

knight = KnightPath.new([1, 1], [8,6])
knight.graph_bfs

knight = KnightPath.new([3, 3], [4,3])
knight.graph_bfs

knight = KnightPath.new([3, 3], [3,4])
knight.graph_bfs

knight = KnightPath.new([2, 2], [4,4])
knight.graph_bfs
