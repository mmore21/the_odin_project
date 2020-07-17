class Graph
  attr_accessor :root
  def initialize(root)
    @root = Node.new(root)
    @used = [@root.point]
    create
  end

  # change points variable name to something more relevant because possible_values returns array of nodes instead of array of points
  def create(nodes = [@root])
    until @used.size == 64
      nodes.each do |n|
        @points = possible_values(n)
      end
      @used << @points unless @points.any? { |p| @used.include?(p) }
      # p @used.size
      nodes = @points
    end
  end

  def possible_values(node)
    values = []
    [node.point].each do |x,y|
      values += [[x+2, y+1], [x+2, y-1], [x-2, y+1], [x-2, y-1], [x+1, y+2], [x+1, y-2], [x-1, y+2], [x-1, y-2]]
    end
    values.select! { |x,y| (x >= 1 && x <= 8) && (y >= 1 && y <= 8) }
    values.reject! { |p| @used.include?(p) }
    values.each do |p|
      child = Node.new(p)
      child.parents << node
      node.children << child
    end
    return node.children
  end
end



class Node
  attr_accessor :parents, :children, :level
  attr_reader :point
  def initialize(point, parents=[], children=[], level=nil)
    @point = point
    @parents = parents
    @children = children
    @level = level
  end
end
