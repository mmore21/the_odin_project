require_relative 'graph.rb'

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
      p current.point
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

path = KnightPath.new([3, 3], [7,3])
p path.graph_bfs
