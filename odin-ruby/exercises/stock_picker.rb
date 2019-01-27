def stock_picker(stocks)
  # variables that will store the highest and lowest values as function iterates through the stock array
  high = nil
  low = nil
  # variable that stores the max difference (highest positive integer)
  # if the numbers in array are decreasing sequentially, the difference will be zero (as in not to buy)
  diff = 0
  # checks differences of each element in the stock array subtracted by each element in the stock array
  stocks.each do |num1|
    stocks.each do |num2|
      # checks if the buy day is before sell day
      # (i.e. can't buy something on day 5 and sell it on day 1)
      if stocks.index(num1) < stocks.index(num2)
        if num2 - num1 > diff
          diff = num2 - num1
          high = num2
          low = num1
        end
      end
    end
  end
  if diff > 0
    puts "Buy on day #{stocks.index(low)} for $#{low} and sell on day #{stocks.index(high)} for $#{high}. This will maximize your profit at $#{diff}!"
  else
    puts "Do not buy this week! The stocks will not increase in price."
  end
end

# the array below is a test case
# change it to see different results
array = [17,3,6,9,15,8,6,12,19]
stock_picker(array)