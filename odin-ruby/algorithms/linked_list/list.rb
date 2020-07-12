class LinkedList

  attr_reader :list

  class Node
    attr_accessor :value, :next_node

    def initialize(value=nil, next_node=nil)
      @value = value
      @next_node = next_node
    end
  end

  def initialize(list=[])
    @list = []
    # Adds items from given array to list unless already empty
    unless list.empty?
      list.each do |item|
        append(item)
      end
      link_nodes
    end
  end

  def append(data)
    @list << Node.new(data)
    link_nodes
  end

  def prepend(data)
    @list.unshift(Node.new(data, @list[0]))
    link_nodes
  end

  def size
    @list.size
  end

  def head
    @list.first
  end

  def tail
    @list.last
  end

  def at(index)
    @list[index]
  end

  def pop
    @list.delete_at(-1)
    link_nodes
  end

  def contains?(value)
    @list.any? { |node| node.value == value }
  end

  def find(data)
    @list.each_with_index do |node,index|
      puts node.value
      puts index
      puts data
      if node.value == data
        return index
      else
        return nil
      end
    end
  end

  def to_s
    str_array = @list.map { |i| "( #{i.value} )" }
    puts str_array.join(" -> ")
  end

  # extra credit
  def insert_at(index, data)
    @list.insert(index, Node.new(data))
    link_nodes
  end

  def remove_at(index)
    @list.delete_at(index)
    link_nodes
  end

  # separate method to link nodes
  def link_nodes
    @list.each_with_index do |node, index|
      unless node == @list.last || @list.size < 2
        node.next_node = @list[index+1]
      else
        node.next_node = nil
      end
    end
  end
end

def main():
list = LinkedList.new([1,2])

list.append(5)
list.prepend(9)
puts list
puts list.size
puts list.head
puts list.tail
puts list.at(0)
list.pop
list.to_s
puts list.contains?(8)
puts list.contains?(2)
list.insert_at(1,6)
list.remove_at(1)
p.list