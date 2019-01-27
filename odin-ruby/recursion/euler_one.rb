# project euler #1
def sum_of_multiples(sum=0, n=1000)
  if n < 1
    return sum
  elsif n % 3.0 == 0 || n % 5.0 == 0
    sum += n
  end
  sum_of_multiples(sum,n-1)
end

# test(s)
puts sum_of_multiples
