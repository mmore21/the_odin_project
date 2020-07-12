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
    create(@root)
  end

  private

  def create(node)
    children_points = []
    [node.point].each do |x,y|
      children_points += [[x+2, y+1], [x+2, y-1], [x-2, y+1], [x-2, y-1], [x+1, y+2], [x+1, y-2], [x-1, y+2], [x-1, y-2]]
    end
    # limits points to points within [0,8] boundaries for x and y and that have not been used
    children_points.select! { |x,y| (x >= 1 && x <= 8) && (y >= 1 && y <= 8) }
    children_points.reject! { |a| @used.include?(a) }
    # returns false (ends current recursion method) when there are no children and the node.point has already been used (base case)
    # if point had not been used, continues on in order to add the node.point to the used instance variable array
    return false if children_points.empty? && @used.include?(node.point)
    @used << node.point
    # creates new node from each array in the children array
    children_points.each do |a|
      child = Node.new(a)
      child.parent = node
      node.children << child
      create(child)
    end
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

knight = KnightPath.new([3, 3], [8,8])
knight.graph_bfs
