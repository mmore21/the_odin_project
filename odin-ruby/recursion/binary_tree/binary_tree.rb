class BinaryTree
  attr_accessor :root
  
  class Node
    attr_accessor :value, :parent, :left_child, :right_child
    def initialize(value, parent=nil, left_child=nil, right_child=nil)
      @value = value
      @parent = parent
      @left_child = left_child
      @right_child = right_child
    end
  end
  
  def initialize(list)
    @list = list
  end

  def build_tree
    @list.each do |value|
      if (defined?(@root)).nil?
        @root = Node.new(value)
      else
        node = Node.new(value)
        insert(node, @root)
      end
    end
  end
  
  def insert(node, parent)
    
    if (node.value < parent.value && parent.left_child != nil)
      insert(node, parent.left_child)
    elsif node.value < parent.value
      node.parent = parent
      parent.left_child = node
      return true
    end
    
    if (node.value > parent.value && parent.right_child != nil)
      insert(node, parent.right_child)
    elsif node.value > parent.value
      node.parent = parent
      parent.right_child = node
      return true
    end
  end
  
  def breadth_first_search(target, root=@root)
    queue = [root]
    while !queue.empty?
      current = queue.shift
      return current if current.value == target
      queue.push(current.left_child) if !current.left_child.nil?
      queue.push(current.right_child) if !current.right_child.nil?
    end
    return nil
  end
  
  # pre-order dfs using pre-order
  def depth_first_search(target, root=@root)
    stack = [root]
    while !stack.empty?
      current = stack.pop
      puts current.value
      return current if current.value == target
      # append the left children first for post-order dfs (vise-versa)
      stack.push(current.right_child) if !current.right_child.nil?
      stack.push(current.left_child) if !current.left_child.nil?
    end
    return nil
  end

  # pre-order dfs using recursion
  def dfs_rec(value, node=@root)
    return nil if node.nil?
    return node if node.value == value
    left = dfs_rec(value, node.left_child)
    right = dfs_rec(value, node.right_child)
    left or right
  end
end
