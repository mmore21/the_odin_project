sum = 0
number1 = 1
number2 = 2

def fibonacci(num1, num2)
    x = num1
    y = num2
    x = num1 + num2
    y = num2 + x
    return x, y
end

while number1 < 4000000 && number2 < 4000000
    if number1 % 2 == 0
        sum += number1
    elsif number2 % 2 == 0
        sum += number2
    else
    end
    number1, number2 = fibonacci(number1, number2)    
end

puts sum.to_s