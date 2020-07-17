n = 600851475143

def findpart(x)
    i = 2
    while i <= x
        if x % i == 0
            return i
        end
        i += 1
    end
end

check = false
while check == false
    a=findpart(n)
    if a != n
        n = n / a
    else
        puts 'The largest prime factor is: ' + n
        check = true
    end
end