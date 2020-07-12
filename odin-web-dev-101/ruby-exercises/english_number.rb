def english_number number
    if number < 0
        return 'Please enter a number that isn\'t negative.'
    end
    if number == 0
        return 'zero'
    end

    numString= '' # this is the string that is returned

    onesPlace = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
    
    tensPlace = ['ten', 'twenty', 'thirty', 'fourty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety']

    teenagers = ['eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen']

    # 'left' is how much of the number we still have left to write out
    # 'write' is the part we are writing out right now
    # no pun intended ;)

    left = number

	# 1,000,000,000
    write = left/1000000000
    left = left - write*1000000000

    if write > 0
        billions = englishNumber write
        numString = numString + billions + ' billion'
        if left > 0
            numString = numString + ' '
        end
    end

	# 1,000,000
    write = left/1000000
    left = left - write*1000000

    if write > 0
        millions = englishNumber write
        numString = numString + millions + ' million'
        if left > 0
            numString = numString + ' '
        end
    end

	# 1,000
    write = left/1000
    left = left - write*1000

    if write > 0
        thousands = englishNumber write
        numString = numString + thousands + ' thousand'
        if left > 0
            numString = numString + ' '
        end
    end
    

	# 100
    write = left/100
    left = left - write*100
    
    if write > 0
        hundreds = englishNumber write
        numString = numString + hundreds + ' hundred'
        if left > 0
            numString = numString + ' '
        end
    end

    write = left/10
    left = left - write*10

    if write > 0
        if ((write == 1) and (left > 0))
            numString = numString + teenagers[left-1] # -1 because the teenager[3] is fourteen, not thirteen
        left = 0
        else
            numString = numString + tensPlace[write-1]
        end
    
        if left > 0
            numString = numString + '-'
        end
    end

    write = left
    left = 0
    
    if write > 0
        numString = numString + onesPlace[write-1]
    end

    numString
end

def beerSong(number)
    count = 0
    while number > 1
        if count != 0
            puts 'Take one down and pass it around, ' + englishNumber(number) + ' bottles of beer on the wall.'
            puts
        end
        puts englishNumber(number).capitalize + ' bottles of beer on the wall, ' + englishNumber(number) + ' bottles of beer.'
        number = number - 1
        count = count + 1
    end
    puts 'Take one down and pass it around, one bottle of beer on the wall.'
    puts
    puts 'One bottle of beer on the wall, one bottle of beer.'
    puts 'Take one down and pass it around, no more bottles of beer on the wall.'
    puts
    puts 'No more bottles of beer on the wall, no more bottles of beer.'
    puts 'Go to the store and buy some more, ninety-nine bottles of beers on the wall.'
end

puts 'Enter a number to convert it to the word in English!'
gets_number = gets.chomp.to_i
puts englishNumber(gets_number)

puts 'And now for a song about beer!'
puts 'How many bottles of beer do you have on the wall?'
gets_number = gets.chomp.to_i
puts beerSong(gets_number)