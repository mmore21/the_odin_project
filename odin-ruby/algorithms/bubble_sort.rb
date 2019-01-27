def bubble_sort(array)
  # array.length - 1 is the length because array starts at array[0]
  length = array.length - 1
  # executes loop array.length times accordingly
  length.times do
    # iterates over each value and checks using if statememnt
    array.each do |i|
      # i must be equal to array.index(i), or else it would  be equal to the value of the array, not the index
      i = array.index(i)
      # swaps values if array[i] is greater than array[i+1]
      if (array[i] <=> array[i+1]) == 1
        array[i], array[i+1] = array[i+1], array[i]
      end
    end
  end
  puts "The final array is: #{array}."
end

def bubble_sort_by(list)
  # stops function if any value of array is a FixNum
  if list.any? { |v| v.is_a? Integer }
    puts "This array only accepts arrays with strings or symbols."
    return nil
  end
  # assumes there are no sorted values yet
  sorted = 0
  # n is how many times the method will iterate through the list (list-1 because list starts at 0)
  n = list.length - 1
  # continues until sorted values (starting from the right) is equal to the length of the array (goes from right to left in the array)
  while sorted < list.length
    # only sorts n-sorted times because the far right 'sorted' values will be in order already from previous iterations
    (n-sorted).times do |i|
      # references to the block and swaps values of list if the difference is greater than 0 which would mean the first value is greater
      if yield(list[i], list[i+1]) > 0
        list[i], list[i+1] = list[i+1], list[i]
      end
    end
    # adds one to the sorted value, because one iteration is complete and the list.last value is in order
    sorted += 1
  end
  puts "The final array is: #{list}."
end

# ----- TEST CASES -----
bubble_sort([4,3,78,2,0,2])

puts

bubble_sort_by(["hello","hey", "hi", "p"]) do |left,right|
  left.length - right.length
end

puts

bubble_sort_by(["test", "case", :symbol, "wow", :a, "programming", "ruby", "ruby on rails", :web_dev]) do |left,right|
  left.length - right.length
end

puts

bubble_sort_by(["test", 24, "hello", "wow", "a", 432, "ruby", "ruby on rails", 12]) do |left,right|
  left.length - right.length
end