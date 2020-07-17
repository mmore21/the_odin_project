# known bug where running (range).my_inject(value, operator) returns undefined length method (fails to convert to array from range)
# if any other bugs are seen or suggestions for improvement (yes, the my_inject, my_map, and my_count need to be refactored), feel free to let me know

module Enumerable
  def my_each
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    i = 0
    array = []
    while i < self.length
      if yield(self[i]) == true
        array << self[i]
      end
      i += 1
    end
    return array
  end

  def my_all?
    self.my_each do |i|
      if yield(i) == false
        return false
      end
    end
    return true
  end

  def my_any?
    self.my_each do |i|
      if yield(i) == true
        return true
      end
    end
    return false
  end

  def my_none?
    self.my_each do |i|
      if yield(i) == true
        return false
      end
    end
    return true
  end

  def my_count(param=nil)
    if self.is_a? Range
      array = self.to_a
    else
      array = self
    end
    i = 0
    if block_given?
      array.my_each do |j|
        i += 1 if yield(j)
      end
    elsif param != nil
      array.my_each do |j|
        i += 1 if j == param
      end
    else
      array.my_each do
        i += 1
      end
    end
    return i
  end

  def my_map(proc = nil)
    array = []
    if self.is_a? Range
      init_array = self.to_a
      init_array.my_each do |i|
        array << yield(i)
      end
    elsif proc != nil
      self.my_each do |i|
        array << proc.call(i)
      end
    else
      self.my_each do |i|
        array << yield(i)
      end
    end
    array
  end

  def my_inject(accumulator = 0, param = nil)
    case accumulator == 0
      when self.my_all? { |i| i.is_a? Fixnum} then accumulator = 0
      when self.my_all? { |i| i.is_a? String } then accumulator = ''
      else raise ArgumentError.new("no conversion of Fixnum into String (TypeError)")
    end
    if self.is_a? Range
        array = self.to_a
        array.my_each do |element|
            accumulator = yield(accumulator, element)
        end
    elsif param != nil
        i = 0
        accumulator = self[i]
        while i < self.my_count - 1
            accumulator = accumulator.send param, self[i+1]
            i += 1
        end
    else
        self.my_each do |element|
        accumulator = yield(accumulator, element)
        end
    end
    accumulator
  end

  def multiply_els
    self.my_inject(1) { |product, n| product * n } if self.my_all? { |n| n.is_a? Fixnum }
  end

end
