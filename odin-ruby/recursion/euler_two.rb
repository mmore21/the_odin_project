# project euler 2
def fib(sum=0, n1=1, n2=2, highest_val=4000000)
  if n1 > highest_val || n2 > highest_val
    return sum
  elsif n1 % 2.0 == 0
    sum += n1
  elsif n2 % 2.0 == 0
    sum += n2
  end
  temp = n2
  n1 += n2
  n2 = n1 + temp
  fib(sum, n1, n2, highest_val) 
end

# test(s)
puts "The sum of all even-valued fibonacci terms under 4 million is #{fib}."
