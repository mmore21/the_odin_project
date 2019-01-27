# separate script file that creates the binary tree
require_relative "binary_tree.rb"

array = [1,2,3]

tree = BinaryTree.new(array)
tree.build_tree
puts tree.inspect