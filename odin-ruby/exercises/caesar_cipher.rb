alphabet = ("a".."z").to_a
capitals = ("A".."Z").to_a
cipher = []
puts "Please enter a phrase to cipher."
getCode = gets.chomp.to_s
puts "Please enter the number (step) to cipher it by."
getNum = gets.chomp.to_i
# splits the user input into an array
startArray = getCode.split('')

startArray.each do |i|
  # checks if the given letter is in the (lowercase) alphabet and executes accordingly
  if alphabet.include? i
    index_num = alphabet.index(i)
    new_index = index_num + getNum
    while new_index > 26
      new_index -= 26
    end
    newLetter = alphabet[new_index]
    cipher << newLetter
  elsif capitals.include? i
    index_num = capitals.index(i)
    new_index = index_num + getNum
    while new_index > 26
      new_index -= 26
    end
    newLetter = capitals[new_index]
    cipher << newLetter
  else
    cipher << i
  end
end

cipher.join('')