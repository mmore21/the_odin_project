# separate script file that creates the binary tree
require_relative "binary_tree.rb"

# change array values as needed
array = [1,2,3]

tree = BinaryTree.new(array)
tree.build_tree

tree.inspect
